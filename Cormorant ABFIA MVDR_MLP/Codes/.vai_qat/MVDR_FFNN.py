# GENETARED BY NNDCT, DO NOT EDIT!

import torch
from torch import tensor
import pytorch_nndct as py_nndct

class MVDR_FFNN(py_nndct.nn.NndctQuantModel):
    def __init__(self):
        super(MVDR_FFNN, self).__init__()
        self.module_0 = py_nndct.nn.Input() #MVDR_FFNN::input_0(MVDR_FFNN::nndct_input_0)
        self.module_1 = py_nndct.nn.quant_input() #MVDR_FFNN::MVDR_FFNN/QuantStub[quant]/137(MVDR_FFNN::nndct_quant_stub_1)
        self.module_2 = py_nndct.nn.Linear(in_features=3, out_features=512, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer1]/ret.5(MVDR_FFNN::nndct_dense_2)
        self.module_3 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/LeakyReLU[relu1]/ret.7(MVDR_FFNN::nndct_leaky_relu_3)
        self.module_4 = py_nndct.nn.Linear(in_features=512, out_features=1024, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer2]/ret.9(MVDR_FFNN::nndct_dense_4)
        self.module_5 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/LeakyReLU[relu2]/ret.11(MVDR_FFNN::nndct_leaky_relu_5)
        self.module_6 = py_nndct.nn.Linear(in_features=1024, out_features=2048, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer3]/ret.13(MVDR_FFNN::nndct_dense_6)
        self.module_7 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/LeakyReLU[relu3]/ret.15(MVDR_FFNN::nndct_leaky_relu_7)
        self.module_8 = py_nndct.nn.Linear(in_features=2048, out_features=1024, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer4]/ret.17(MVDR_FFNN::nndct_dense_8)
        self.module_9 = py_nndct.nn.LeakyReLU(negative_slope=0.1015625, inplace=False) #MVDR_FFNN::MVDR_FFNN/LeakyReLU[relu4]/ret.19(MVDR_FFNN::nndct_leaky_relu_9)
        self.module_10 = py_nndct.nn.Linear(in_features=1024, out_features=32, bias=True) #MVDR_FFNN::MVDR_FFNN/Linear[layer5]/ret.21(MVDR_FFNN::nndct_dense_10)
        self.module_11 = py_nndct.nn.dequant_output() #MVDR_FFNN::MVDR_FFNN/DeQuantStub[dequant]/163(MVDR_FFNN::nndct_dequant_stub_11)

    @py_nndct.nn.forward_processor
    def forward(self, *args):
        output_module_0 = self.module_0(input=args[0])
        output_module_0 = self.module_1(input=output_module_0)
        output_module_0 = self.module_2(output_module_0)
        output_module_0 = self.module_3(output_module_0)
        output_module_0 = self.module_4(output_module_0)
        output_module_0 = self.module_5(output_module_0)
        output_module_0 = self.module_6(output_module_0)
        output_module_0 = self.module_7(output_module_0)
        output_module_0 = self.module_8(output_module_0)
        output_module_0 = self.module_9(output_module_0)
        output_module_0 = self.module_10(output_module_0)
        output_module_0 = self.module_11(input=output_module_0)
        return output_module_0
