classdef MatMul_To_AddLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.
    %#codegen

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

    methods(Static, Hidden)
        % Specify the properties of the class that will not be modified
        % after the first assignment.
        function p = matlabCodegenNontunableProperties(~)
            p = {
                % Constants, i.e., Vars, NumDims and all learnables and states
                'Vars'
                'NumDims'
                'functional_5_1_de_2'
                'functional_5_1_de_7'
                'functional_5_1_out_1'
                };
        end
    end


    methods(Static, Hidden)
        % Instantiate a codegenable layer instance from a MATLAB layer instance
        function this_cg = matlabCodegenToRedirected(mlInstance)
            this_cg = my_model.coder.MatMul_To_AddLayer1000(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = my_model.MatMul_To_AddLayer1000(cgInstance.Name);
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
            this_ml.functional_5_1_de_2 = cgInstance.functional_5_1_de_2;
            this_ml.functional_5_1_de_7 = cgInstance.functional_5_1_de_7;
            this_ml.functional_5_1_out_1 = cgInstance.functional_5_1_out_1;
        end
    end

    methods
        function this = MatMul_To_AddLayer1000(mlInstance)
            this.Name = mlInstance.Name;
            this.NumInputs = 2;
            this.OutputNames = {'output'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = my_model.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
            this.functional_5_1_de_2 = mlInstance.functional_5_1_de_2;
            this.functional_5_1_de_7 = mlInstance.functional_5_1_de_7;
            this.functional_5_1_out_1 = mlInstance.functional_5_1_out_1;
        end

        function [output] = predict(this, input__, inputNumDims__)
            if isdlarray(input__)
                input_ = stripdims(input__);
            else
                input_ = input__;
            end
            inputNumDims = numel(inputNumDims__);
            input = my_model.coder.ops.permuteInputVar(input_, ['as-is'], 2);

            [output__, outputNumDims__] = MatMul_To_AddGraph1000(this, input, inputNumDims, false);
            output_ = my_model.coder.ops.permuteOutputVar(output__, ['as-is'], 2);

            output = dlarray(single(output_), repmat('U', 1, max(2, outputNumDims__)));
        end

        function [output, outputNumDims1001] = MatMul_To_AddGraph1000(this, input, inputNumDims, Training)

            % Execute the operators:
            % MatMul:
            [functional_5_1_de_3, functional_5_1_de_3NumDims] = my_model.coder.ops.onnxMatMul(input, this.functional_5_1_de_2, inputNumDims, this.NumDims.functional_5_1_de_2);

            % Add:
            functional_5_1_de_1 = functional_5_1_de_3 + this.Vars.functional_5_1_dense;
            functional_5_1_de_1NumDims = max(functional_5_1_de_3NumDims, this.NumDims.functional_5_1_dense);

            % Relu:
            X1000 = dlarray(my_model.coder.ops.extractIfDlarray(functional_5_1_de_1));
            Y1001 = relu(X1000);
            functional_5_1_de_4 = my_model.coder.ops.extractIfDlarray(Y1001);
            functional_5_1_de_4NumDims = functional_5_1_de_1NumDims;

            % MatMul:
            [functional_5_1_de_8, functional_5_1_de_8NumDims] = my_model.coder.ops.onnxMatMul(functional_5_1_de_4, this.functional_5_1_de_7, functional_5_1_de_4NumDims, this.NumDims.functional_5_1_de_7);

            % Add:
            functional_5_1_de_6 = functional_5_1_de_8 + this.Vars.functional_5_1_de_5;
            functional_5_1_de_6NumDims = max(functional_5_1_de_8NumDims, this.NumDims.functional_5_1_de_5);

            % Relu:
            X1002 = dlarray(my_model.coder.ops.extractIfDlarray(functional_5_1_de_6));
            Y1003 = relu(X1002);
            functional_5_1_de_9 = my_model.coder.ops.extractIfDlarray(Y1003);
            functional_5_1_de_9NumDims = functional_5_1_de_6NumDims;

            % MatMul:
            [functional_5_1_out_2, functional_5_1_out_2NumDims] = my_model.coder.ops.onnxMatMul(functional_5_1_de_9, this.functional_5_1_out_1, functional_5_1_de_9NumDims, this.NumDims.functional_5_1_out_1);

            % Add:
            output = functional_5_1_out_2 + this.Vars.functional_5_1_outpu;
            outputNumDims = max(functional_5_1_out_2NumDims, this.NumDims.functional_5_1_outpu);

            % Set graph output arguments
            outputNumDims1001 = outputNumDims;

        end

    end

end