classdef FilterData
    methods (Static)
        function result = filter(dataRaw, N_Low, F3dB_Low, Ast_Low, N_High, F3dB_High, Ast_High)
            % Apply IIR (Chebyshev Type II) lowpass filter to the data with 8th order, .04*PI
            % cutoff frequency, and stopband attenuation of 20 dB
            d = fdesign.lowpass('N,F3dB',N_Low,F3dB_Low);
            setspecs(d,'N,F3dB,Ast',N_Low,F3dB_Low,Ast_Low);
            Hcheby2Low = design(d,'cheby2','SystemObject',true);
            e = fdesign.highpass('N,F3dB',N_High,F3dB_High);
            setspecs(e,'N,F3dB,Ast',N_High,F3dB_High,Ast_High);
            Hcheby2High = design(e,'cheby2','SystemObject',true);
            result = Hcheby2High(Hcheby2Low(dataRaw));
            %{
            figure(7);
            hold;
            Low = Hcheby2Low(dataRaw);
            High = Hcheby2High(dataRaw);
            plot(dataRaw(5000000:5002000));
            plot(Low(5000000:5002000));
            plot(High(5000000:5002000));
            plot(result(5000000:5002000));
            %}
        end
    end
end