import numpy as np
import os
os.environ['ETS_TOOLKIT'] = 'qt4'
os.environ['QT_API'] = 'pyqt5'
from mayavi import mlab
from tvtk.util.ctf import PiecewiseFunction
# mlab.init_notebook()

indir = r'Z:\Simulation\moon\run1.1'
outidr = r'Z:\Simulation\moon\run1.1\out\render'

# scale
nx, ny, nz = 800, 500, 200
di = 20
Lx, Ly, Lz = nx/di, ny/di, nz/di
lx = np.linspace(0, Lx, nx)
ly = np.linspace(0, Ly, ny)
lz = np.linspace(0, Lz, nz)

# parameters
n0 = 487.8061
qi = 5.1200e-04
vA = 0.05

def reshape_data(data):
    data = data.reshape(nx, ny, nz, order='F')
    # fd = np.zeros((ny, nx, nz))
    # for i in range(nz):
        # fd[:, :, i] = data[:, :, i].T
    return data

def read_scalar(name):
    os.chdir(indir)
    return reshape_data(np.fromfile(name, np.float32))

def read_vector(name):
    os.chdir(indir)
    fd = np.fromfile(name, np.float32).reshape(nx * ny * nz, 3, order='F')
    x = reshape_data(fd[:, 0])
    y = reshape_data(fd[:, 1])
    z = reshape_data(fd[:, 2])
    return x, y, z


norm = vA
_, _, s = read_vector('B_t020.00.bsd')
# s = read_scalar('Ne_t008.00.bsd')
print(s.shape)
s = s/norm

os.chdir(outidr)
mlab.figure(size=(1000, 600), bgcolor=(1, 1, 1), fgcolor=(0, 0, 0))
vm = mlab.pipeline.volume(mlab.pipeline.scalar_field(s), vmin=s.min(), vmax=s.max())
cbar = mlab.colorbar(vm, orientation='vertical')
mlab.axes(xlabel=r'$X[c/\omega_{pi}]$', ylabel=r'$Y[c/\omega_{pi}]$', zlabel=r'$Z[c/\omega_{pi}]$',
          ranges=[0, Lx, 0, Ly, 0, Lz], nb_labels=3, color=(0, 0, 0))
mlab.title(r'Bz at $\Omega_{ci}t = 8$', size=0.2)
mlab.outline()

# 创建透明度传递函数
opacity_tf = PiecewiseFunction()

# 设置透明度控制点
opacity_tf.add_point(s.min(), 1.0)  # 完全不透明
opacity_tf.add_point(-1, 0.0)  # 开始透明区间
opacity_tf.add_point(1, 0.0)   # 结束透明区间
opacity_tf.add_point(s.max(), 0.1)   # 完全不透明

# 将透明度传递函数应用于 volume_property
vm._volume_property.set_scalar_opacity(opacity_tf)
# 重新渲染
mlab.draw()
mlab.show()

os.chdir(outidr)
# mlab.savefig('render.png')
