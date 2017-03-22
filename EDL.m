classdef EDL
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ElectrolyteConcentration;
        Potential;
        PotentialProfiles;
        ChargeDensity;
        InnerPotential;
        xmesh;
        xmesh_charge;
        Debye;
        
        diff_C;
        C_curve=[];
        C_inner=1;
    end
    properties (Constant)
        NA=6.022e23;
        e_constant=1.6e-19;
        z0=8.854e-12;
        z=80;
        rhoMax=1.445e17;
        T=300;
        
        BZ=1.38e-23;
        OHP=4e-10;
        PotentialRange=linspace(-.8,.8,100);
        Faraday=96485.3329;
    end
    
    methods 
        function obj=Solver(obj)
            obj.InnerPotential=fzero(@GC,obj.Potential);
            obj.Debye=1/sqrt(2*obj.ElectrolyteConcentration*obj.e_constant^2*obj.NA/(obj.z*obj.z0*obj.BZ*obj.T));
            obj.xmesh=[0,linspace(obj.OHP,10*obj.Debye,100)];  
            obj.PotentialProfiles(1)=obj.Potential;
            obj.PotentialProfiles(2:101)=obj.InnerPotential*exp(-1/obj.Debye*obj.xmesh(2:101));
            obj.xmesh_charge=obj.xmesh(2:101);
            obj.ChargeDensity=obj.Faraday*obj.ElectrolyteConcentration*(-obj.e_constant*obj.PotentialProfiles(2:101)/(obj.BZ*obj.T));
            obj.diff_C=1/(1/obj.C_inner+1/(2*(2*obj.z*obj.z0*obj.NA*obj.ElectrolyteConcentration*obj.BZ*obj.T)^.5*obj.e_constant/(2*obj.BZ*obj.T)*cosh(obj.e_constant*obj.InnerPotential/(2*obj.BZ*obj.T))));
           
                
            function q_balance=GC(inner)
                     q_balance=-2*(2*obj.z*obj.z0*obj.NA*obj.ElectrolyteConcentration*obj.BZ*obj.T)^.5*sinh(obj.e_constant*inner/(2*obj.BZ*obj.T))+obj.C_inner*(obj.Potential-inner);
                     
            end
            
        end
        end

    
end

