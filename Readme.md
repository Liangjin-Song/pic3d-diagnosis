# pic3d-diagnosis

## Introduction

Diagnosis of pic3d simulation code. Using matlab for diagnosis. Before using this code, you must have the data obtained by the particle-in-cell simulation code which is developed by the author.

+ `slj`: the package including some useful components
+ `pic3d`: the package including some diagnosis for the specific model.
+ `articles`: Drawings for published articles
+ `others`: Previous code or code from elsewhere.

## Basic usage

+ read the parameters

  ```matlab
  indir='E:\PIC\Cold-Ions\mie100\data';
  outdir='E:\PIC\Cold-Ions\mie100\out';
  prm=slj.Parameters(indir, outdir);
  ```
+ read the field data, such the magnetic field when $t=0$

  ```matlab
  b=prm.read('B', 0);
  ```
