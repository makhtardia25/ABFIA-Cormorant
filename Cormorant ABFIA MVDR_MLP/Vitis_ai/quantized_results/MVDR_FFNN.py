# GENETARED BY NNDCT, DO NOT EDIT!

import torch
from torch import tensor
import pytorch_nndct as py_nndct

class MVDR_FFNN(py_nndct.nn.NndctQuantModel):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        self.module_0 = py_nndct.nn.Input() #MVDR_FFNN::input_0(MVDR_FFNN::nndct_input_0)
        self.module_1 = py_nndct.nn.Linear(in_features=3, out_features=256, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer1]/ret.3(MVDR_FFNN::nndct_dense_1)
        self.module_2 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/ret.5(MVDR_FFNN::nndct_leaky_relu_2)
        self.module_3 = py_nndct.nn.Linear(in_features=256, out_features=512, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer2]/ret.7(MVDR_FFNN::nndct_dense_3)
        self.module_4 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/ret.9(MVDR_FFNN::nndct_leaky_relu_4)
        self.module_5 = py_nndct.nn.Linear(in_features=512, out_features=512, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer3]/ret.11(MVDR_FFNN::nndct_dense_5)
        self.module_6 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/ret.13(MVDR_FFNN::nndct_leaky_relu_6)
        self.module_7 = py_nndct.nn.Linear(in_features=512, out_features=1024, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer4]/ret.15(MVDR_FFNN::nndct_dense_7)
        self.module_8 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/ret.17(MVDR_FFNN::nndct_leaky_relu_8)
        self.module_9 = py_nndct.nn.Linear(in_features=1024, out_features=32, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer5]/ret(MVDR_FFNN::nndct_dense_9)

    @py_nndct.nn.forward_processor
    def forward(self, *args):
        output_module_0 = self.module_0(input=args[0])
        output_module_0 = self.module_1(output_module_0)
        output_module_0 = self.module_2(output_module_0)
        output_module_0 = self.module_3(output_module_0)
        output_module_0 = self.module_4(output_module_0)
        output_module_0 = self.module_5(output_module_0)
        output_module_0 = self.module_6(output_module_0)
        output_module_0 = self.module_7(output_module_0)
        output_module_0 = self.module_8(output_module_0)
        output_module_0 = self.module_9(output_module_0)
        return output_module_0
