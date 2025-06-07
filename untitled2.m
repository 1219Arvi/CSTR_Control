FF2 = readfis('FF2.fis');
FF2forCodegen = getFISCodeGenerationData(FF2);
busInfo = Simulink.Bus.createObject(FF2forCodegen);
busName = busInfo.busName
FF2StructForSimulink = Simulink.Bus.createMATLABStruct(busName);