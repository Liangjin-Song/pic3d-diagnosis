function fd=read_field(obj,name,time)
%% writen by Liangjin Song on 20210326
% read field
%%
fd=Field();
fd.name=name;
fd.time=time;
fd.norm=1;
filename=[name,'_t',num2str(time,'%06.2f'),'.bsd'];
%% ======================================================================== %%
%% read the scalar
if strcmp(name,'Ne')
    fd.norm=obj.value.n0;
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'Ni')
    fd.norm=obj.value.n0;
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'Nl')
    fd.name='Ni';
    fd.norm=obj.value.n0;
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'Nh')
    fd.name='Nic';
    fd.norm=obj.value.n0;
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'Nhe')
    fd.name='Nice';
    fd.norm=obj.value.n0;
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'stream')
    fd.type=FieldType.Stream;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'divE')
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
elseif strcmp(name, 'divB')
    fd.type=FieldType.Scalar;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Scalar);
%% ======================================================================== %%
%% read the vector 
elseif strcmp(name,'B')
    fd.norm=1;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'E') 
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'J')
    fd.norm=obj.value.qi*obj.value.n0*obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Vi')
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Ve')
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Vh')
    fd.norm='Vic';
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Vhe')
    fd.norm='Vice';
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Vl')
    fd.norm='Vi';
    fd.norm=obj.value.vA;
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'Amp')
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'qfluxi')
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'qfluxl')
    fd.name='qfluxi';
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'qfluxe')
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'qfluxh')
    fd.name='qfluxic';
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
elseif strcmp(name,'qfluxhe')
    fd.name='qfluxice';
    fd.type=FieldType.Vector;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Vector);
%% ======================================================================== %%
%% read the tensor 
elseif strcmp(name,'Pi')
    fd.norm=obj.value.n0*obj.value.mi*obj.value.vith*obj.value.vith;
    fd.type=FieldType.Tensor;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Tensor);
elseif strcmp(name,'Pe')
    fd.norm=obj.value.n0*obj.value.me*obj.value.veth*obj.value.veth;
    fd.type=FieldType.Tensor;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Tensor);
elseif strcmp(name,'Pl')
    fd.name='Pi';
    fd.norm=obj.value.n0*obj.value.ml*obj.value.vlth*obj.value.vlth;
    fd.type=FieldType.Tensor;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Tensor);
elseif strcmp(name,'Ph')
    fd.name='Pic';
    fd.norm=obj.value.n0*obj.value.mh*obj.value.vhth*obj.value.vhth;
    fd.type=FieldType.Tensor;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Tensor);
elseif strcmp(name,'Phe')
    fd.name='Pice';
    fd.norm=obj.value.n0*obj.value.me*obj.value.veth*obj.value.veth;
    fd.type=FieldType.Tensor;
    fd.value=reshape_field(obj,read_binary_file(obj, filename),FieldType.Tensor);
%% ======================================================================== %%
%% read the spectrum
elseif strcmp(name, 'spctrme') || strcmp(name, 'spctrml') || strcmp(name, 'spctrmi') || strcmp(name, 'spctrmh') || strcmp(name, 'spctrmhe')
    fd=read_spectrum(obj, name, time);
%% ======================================================================== %%
else
    error('Parameters error!');
end
end
