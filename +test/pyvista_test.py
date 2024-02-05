import numpy as np
import pyvista as pv

values = np.random.random((100, 100, 100))
print(values.shape)

# 首先类似于新建一个空的矩阵
grid = pv.ImageData()

# 然后设置维度，如果想给cell填充数据则维度设置为 矩阵shape + 1，
# 如果是给point填充数据指定为矩阵shape
# 填充cell，颜色就不是渐变的，是每个块一个颜色，正好和ct的数据一样。
grid.dimensions = values.shape

# 设置origin和spacing，这两个参数正好和ct的参数一个意思。
grid.origin = (0, 0, 0)  # The bottom left corner of the data set
grid.spacing = (1, 1, 1)  # These are the cell sizes along each axis

# 设置（网格）矩阵的值
# grid.cell_data["values"] = values.flatten(order="F")  # Flatten the array!
grid["array"] = values.ravel(order="F")

# plot
# grid.plot(show_edges=False)
grid.plot(show_edges=False, cmap="jet")
