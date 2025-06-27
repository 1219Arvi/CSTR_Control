classdef MatMul_To_ReluLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>
    properties (Learnable)
        sequential_dense_Mat
        sequential_dense_1_M
        sequential_dense_2_M
    end

    properties (State)
    end

    properties
        Vars
        NumDims
    end


    methods(Static, Hidden)
        % Specify the path to the class that will be used for codegen
        function name = matlabCodegenRedirect(~)
            name = 'mymodel.coder.MatMul_To_ReluLayer1000';
        end
    end


    methods
        function this = MatMul_To_ReluLayer1000(name)
            this.Name = name;
            this.NumInputs = 2;
            this.OutputNames = {'dense_2'};
        end

        function [dense_2] = predict(this, dense_input, dense_inputNumDims)
            if isdlarray(dense_input)
                dense_input = stripdims(dense_input);
            end
            dense_inputNumDims = numel(dense_inputNumDims);
            dense_input = mymodel.ops.permuteInputVar(dense_input, ['as-is'], 2);

            [dense_2, dense_2NumDims] = MatMul_To_ReluGraph1000(this, dense_input, dense_inputNumDims, false);
            dense_2 = mymodel.ops.permuteOutputVar(dense_2, ['as-is'], 2);

            dense_2 = dlarray(single(dense_2), repmat('U', 1, max(2, dense_2NumDims)));
        end

        function [dense_2] = forward(this, dense_input, dense_inputNumDims)
            if isdlarray(dense_input)
                dense_input = stripdims(dense_input);
            end
            dense_inputNumDims = numel(dense_inputNumDims);
            dense_input = mymodel.ops.permuteInputVar(dense_input, ['as-is'], 2);

            [dense_2, dense_2NumDims] = MatMul_To_ReluGraph1000(this, dense_input, dense_inputNumDims, true);
            dense_2 = mymodel.ops.permuteOutputVar(dense_2, ['as-is'], 2);

            dense_2 = dlarray(single(dense_2), repmat('U', 1, max(2, dense_2NumDims)));
        end

        function [dense_2, dense_2NumDims1001] = MatMul_To_ReluGraph1000(this, dense_input, dense_inputNumDims, Training)

            % Execute the operators:
            % MatMul:
            [sequential_dense_M_1, sequential_dense_M_1NumDims] = mymodel.ops.onnxMatMul(dense_input, this.sequential_dense_Mat, dense_inputNumDims, this.NumDims.sequential_dense_Mat);

            % Add:
            sequential_dense_B_1 = sequential_dense_M_1 + this.Vars.sequential_dense_Bia;
            sequential_dense_B_1NumDims = max(sequential_dense_M_1NumDims, this.NumDims.sequential_dense_Bia);

            % Relu:
            sequential_dense_Rel = relu(dlarray(sequential_dense_B_1));
            sequential_dense_RelNumDims = sequential_dense_B_1NumDims;

            % MatMul:
            [sequential_dense_1_3, sequential_dense_1_3NumDims] = mymodel.ops.onnxMatMul(sequential_dense_Rel, this.sequential_dense_1_M, sequential_dense_RelNumDims, this.NumDims.sequential_dense_1_M);

            % Add:
            sequential_dense_1_1 = sequential_dense_1_3 + this.Vars.sequential_dense_1_B;
            sequential_dense_1_1NumDims = max(sequential_dense_1_3NumDims, this.NumDims.sequential_dense_1_B);

            % Relu:
            sequential_dense_1_R = relu(dlarray(sequential_dense_1_1));
            sequential_dense_1_RNumDims = sequential_dense_1_1NumDims;

            % MatMul:
            [sequential_dense_2_3, sequential_dense_2_3NumDims] = mymodel.ops.onnxMatMul(sequential_dense_1_R, this.sequential_dense_2_M, sequential_dense_1_RNumDims, this.NumDims.sequential_dense_2_M);

            % Add:
            sequential_dense_2_1 = sequential_dense_2_3 + this.Vars.sequential_dense_2_B;
            sequential_dense_2_1NumDims = max(sequential_dense_2_3NumDims, this.NumDims.sequential_dense_2_B);

            % Relu:
            dense_2 = relu(dlarray(sequential_dense_2_1));
            dense_2NumDims = sequential_dense_2_1NumDims;

            % Set graph output arguments
            dense_2NumDims1001 = dense_2NumDims;

        end

    end

end