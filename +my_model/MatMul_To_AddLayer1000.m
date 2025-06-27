classdef MatMul_To_AddLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>
    properties (Learnable)
        functional_5_1_de_2
        functional_5_1_de_7
        functional_5_1_out_1
    end

    properties (State)
    end

    properties
        Vars
        NumDims
    end




    methods
        function this = MatMul_To_AddLayer1000(name)
            this.Name = name;
            this.NumInputs = 2;
            this.OutputNames = {'output'};
        end

        function [output] = predict(this, input, inputNumDims)
            if isdlarray(input)
                input = stripdims(input);
            end
            inputNumDims = numel(inputNumDims);
            input = my_model.ops.permuteInputVar(input, ['as-is'], 2);

            [output, outputNumDims] = MatMul_To_AddGraph1000(this, input, inputNumDims, false);
            output = my_model.ops.permuteOutputVar(output, ['as-is'], 2);

            output = dlarray(single(output), repmat('U', 1, max(2, outputNumDims)));
        end

        function [output] = forward(this, input, inputNumDims)
            if isdlarray(input)
                input = stripdims(input);
            end
            inputNumDims = numel(inputNumDims);
            input = my_model.ops.permuteInputVar(input, ['as-is'], 2);

            [output, outputNumDims] = MatMul_To_AddGraph1000(this, input, inputNumDims, true);
            output = my_model.ops.permuteOutputVar(output, ['as-is'], 2);

            output = dlarray(single(output), repmat('U', 1, max(2, outputNumDims)));
        end

        function [output, outputNumDims1001] = MatMul_To_AddGraph1000(this, input, inputNumDims, Training)

            % Execute the operators:
            % MatMul:
            [functional_5_1_de_3, functional_5_1_de_3NumDims] = my_model.ops.onnxMatMul(input, this.functional_5_1_de_2, inputNumDims, this.NumDims.functional_5_1_de_2);

            % Add:
            functional_5_1_de_1 = functional_5_1_de_3 + this.Vars.functional_5_1_dense;
            functional_5_1_de_1NumDims = max(functional_5_1_de_3NumDims, this.NumDims.functional_5_1_dense);

            % Relu:
            functional_5_1_de_4 = relu(dlarray(functional_5_1_de_1));
            functional_5_1_de_4NumDims = functional_5_1_de_1NumDims;

            % MatMul:
            [functional_5_1_de_8, functional_5_1_de_8NumDims] = my_model.ops.onnxMatMul(functional_5_1_de_4, this.functional_5_1_de_7, functional_5_1_de_4NumDims, this.NumDims.functional_5_1_de_7);

            % Add:
            functional_5_1_de_6 = functional_5_1_de_8 + this.Vars.functional_5_1_de_5;
            functional_5_1_de_6NumDims = max(functional_5_1_de_8NumDims, this.NumDims.functional_5_1_de_5);

            % Relu:
            functional_5_1_de_9 = relu(dlarray(functional_5_1_de_6));
            functional_5_1_de_9NumDims = functional_5_1_de_6NumDims;

            % MatMul:
            [functional_5_1_out_2, functional_5_1_out_2NumDims] = my_model.ops.onnxMatMul(functional_5_1_de_9, this.functional_5_1_out_1, functional_5_1_de_9NumDims, this.NumDims.functional_5_1_out_1);

            % Add:
            output = functional_5_1_out_2 + this.Vars.functional_5_1_outpu;
            outputNumDims = max(functional_5_1_out_2NumDims, this.NumDims.functional_5_1_outpu);

            % Set graph output arguments
            outputNumDims1001 = outputNumDims;

        end

    end

end