classdef MatMul_To_ReluLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.
    %#codegen

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
        % Specify the properties of the class that will not be modified
        % after the first assignment.
        function p = matlabCodegenNontunableProperties(~)
            p = {
                % Constants, i.e., Vars, NumDims and all learnables and states
                'Vars'
                'NumDims'
                'sequential_dense_Mat'
                'sequential_dense_1_M'
                'sequential_dense_2_M'
                };
        end
    end


    methods(Static, Hidden)
        % Instantiate a codegenable layer instance from a MATLAB layer instance
        function this_cg = matlabCodegenToRedirected(mlInstance)
            this_cg = mymodel.coder.MatMul_To_ReluLayer1000(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = mymodel.MatMul_To_ReluLayer1000(cgInstance.Name);
            if isstruct(cgInstance.Vars)
                names = fieldnames(cgInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this_ml.Vars.(fieldname) = dlarray(cgInstance.Vars.(fieldname));
                end
            else
                this_ml.Vars = [];
            end
            this_ml.NumDims = cgInstance.NumDims;
            this_ml.sequential_dense_Mat = cgInstance.sequential_dense_Mat;
            this_ml.sequential_dense_1_M = cgInstance.sequential_dense_1_M;
            this_ml.sequential_dense_2_M = cgInstance.sequential_dense_2_M;
        end
    end

    methods
        function this = MatMul_To_ReluLayer1000(mlInstance)
            this.Name = mlInstance.Name;
            this.NumInputs = 2;
            this.OutputNames = {'dense_2'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = mymodel.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
            this.sequential_dense_Mat = mlInstance.sequential_dense_Mat;
            this.sequential_dense_1_M = mlInstance.sequential_dense_1_M;
            this.sequential_dense_2_M = mlInstance.sequential_dense_2_M;
        end

        function [dense_2] = predict(this, dense_input__, dense_inputNumDims__)
            if isdlarray(dense_input__)
                dense_input_ = stripdims(dense_input__);
            else
                dense_input_ = dense_input__;
            end
            dense_inputNumDims = numel(dense_inputNumDims__);
            dense_input = mymodel.coder.ops.permuteInputVar(dense_input_, ['as-is'], 2);

            [dense_2__, dense_2NumDims__] = MatMul_To_ReluGraph1000(this, dense_input, dense_inputNumDims, false);
            dense_2_ = mymodel.coder.ops.permuteOutputVar(dense_2__, ['as-is'], 2);

            dense_2 = dlarray(single(dense_2_), repmat('U', 1, max(2, dense_2NumDims__)));
        end

        function [dense_2, dense_2NumDims1001] = MatMul_To_ReluGraph1000(this, dense_input, dense_inputNumDims, Training)

            % Execute the operators:
            % MatMul:
            [sequential_dense_M_1, sequential_dense_M_1NumDims] = mymodel.coder.ops.onnxMatMul(dense_input, this.sequential_dense_Mat, dense_inputNumDims, this.NumDims.sequential_dense_Mat);

            % Add:
            sequential_dense_B_1 = sequential_dense_M_1 + this.Vars.sequential_dense_Bia;
            sequential_dense_B_1NumDims = max(sequential_dense_M_1NumDims, this.NumDims.sequential_dense_Bia);

            % Relu:
            X1000 = dlarray(mymodel.coder.ops.extractIfDlarray(sequential_dense_B_1));
            Y1001 = relu(X1000);
            sequential_dense_Rel = mymodel.coder.ops.extractIfDlarray(Y1001);
            sequential_dense_RelNumDims = sequential_dense_B_1NumDims;

            % MatMul:
            [sequential_dense_1_3, sequential_dense_1_3NumDims] = mymodel.coder.ops.onnxMatMul(sequential_dense_Rel, this.sequential_dense_1_M, sequential_dense_RelNumDims, this.NumDims.sequential_dense_1_M);

            % Add:
            sequential_dense_1_1 = sequential_dense_1_3 + this.Vars.sequential_dense_1_B;
            sequential_dense_1_1NumDims = max(sequential_dense_1_3NumDims, this.NumDims.sequential_dense_1_B);

            % Relu:
            X1002 = dlarray(mymodel.coder.ops.extractIfDlarray(sequential_dense_1_1));
            Y1003 = relu(X1002);
            sequential_dense_1_R = mymodel.coder.ops.extractIfDlarray(Y1003);
            sequential_dense_1_RNumDims = sequential_dense_1_1NumDims;

            % MatMul:
            [sequential_dense_2_3, sequential_dense_2_3NumDims] = mymodel.coder.ops.onnxMatMul(sequential_dense_1_R, this.sequential_dense_2_M, sequential_dense_1_RNumDims, this.NumDims.sequential_dense_2_M);

            % Add:
            sequential_dense_2_1 = sequential_dense_2_3 + this.Vars.sequential_dense_2_B;
            sequential_dense_2_1NumDims = max(sequential_dense_2_3NumDims, this.NumDims.sequential_dense_2_B);

            % Relu:
            X1004 = dlarray(mymodel.coder.ops.extractIfDlarray(sequential_dense_2_1));
            Y1005 = relu(X1004);
            dense_2 = mymodel.coder.ops.extractIfDlarray(Y1005);
            dense_2NumDims = sequential_dense_2_1NumDims;

            % Set graph output arguments
            dense_2NumDims1001 = dense_2NumDims;

        end

    end

end