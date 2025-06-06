FF1 = readfis('FF1.fis');
FF1ForCodegen = getFISCodeGenerationData(FF1);
FF1Bus = Simulink.Bus.createObject(FF1ForCodegen);
FF2 = readfis('FF2.fis');
FF2ForCodegen = getFISCodeGenerationData(FF2);
FF2Bus = Simulink.Bus.createObject(FF2ForCodegen);

tau_I =27.27;
tau_D=3.64;
tau_C=1.45;
alpha=0.125;
atau_D=alpha*tau_D;