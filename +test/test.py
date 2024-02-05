import matplotlib.pyplot as plt
import numpy as np
import pyvista as pv

def read_data(filename, norm = 1):
    fd = np.fromfile(filename, dtype=np.float32)
    return fd / norm

class VectorField:
    def __init__(self):
        self.x = None
        self.y = None
        self.z = None

def reshape_vector(fd, nx, ny, nz):
    sfd =  fd.reshape((nx, ny, nz, 3), order='F')
    rfs = VectorField()
    rfs.x = sfd[:, :, :, 0]
    rfs.y = sfd[:, :, :, 1]
    rfs.z = sfd[:, :, :, 2]
    return rfs

def reshape_scalar(fd, nx, ny, nz):
    return fd.reshape((nx, ny, nz), order='F')

def plot(fd):
    pl = pv.Plotter()
    grid = pv.ImageData()
    grid.dimensions = fd.shape
    # origin and grid spacing
    grid.origin = (0, 0, 0)
    grid.spacing = (1, 1, 1)
    grid["array"] = fd.ravel(order="F")
    sargs = dict(vertical=True, title = "Jz",
                 title_font_size=16, label_font_size=14, shadow=True, n_labels=5,
                 font_family="arial")
    # grid.plot(show_edges=False, cmap="bwr", scalar_bar_args=sargs)
    pl.add_mesh(grid, cmap="bwr", show_edges=False, scalar_bar_args=sargs)
    pl.add_axes(line_width=5, labels_off=False)
    pl.save_graphic('D:/Downloads/t3d/python/Jz.pdf')


if __name__ == '__main__':
    nx = 1000
    ny = 500
    nz = 100
    fd = read_data('D:/Downloads/t3d/data/J_t025.00.bsd', norm = 0.0125)
    fd = reshape_vector(fd, nx, ny, nz)
    fd = fd.z[100:250, 100:220, 0:100]
    plot(fd)
