classdef (StrictDefaults) drone_model < matlab.System
  % untitled6 Add summary here
  %
  % NOTE: When renaming the class name untitled6, the file name
  % and constructor name must be updated to use the class name.
  %
  % This template includes most, but not all, possible properties, attributes,
  % and methods that you can implement for a System object in Simulink.

  % Public, tunable properties
  properties (Access=private)
    P
    A
    B
    parameter
  end

  % Public, non-tunable properties
properties (Access=public,Constant)
      %F =  [1.0000    1.7321];
      F = ones(4,13);
    %P = [0.5000    0.1600    0.1600    0.0800    0.0800    0.0600    0.0600    0.0600    9.8100    0.0301    0.0301    0.0301    0.0301    0.0000    0.0000    0.0000    0.0000    0.0392];
% F = [    0.9914    1.7221];
end

  % Discrete state properties
  %properties (ContinuousState)
  properties (DiscreteState)
    state
  end

  % Pre-computed constants or internal states
  properties (Constant)
    initial_state = [0;0;-1;1;0;0;0;0;0;0;0;0;0];
    dt = 0.01;
  end

  methods
    % Constructor
    function obj = drone_model(varargin)
      % Support name-value pair arguments when constructing object
      setProperties(obj,nargin,varargin{:})
    end
  end

  methods (Access = protected)
    %% Common functions
    function setupImpl(obj,x0,A)
      arguments
        obj
        x0
        A 
        %B = [0;1];
      end
      tmp = coder.load("testp.mat");
      obj.P = tmp.P;
%        x0 (13,1) {mustBeNumeric}=[0;0;-1;1;0;0;0;0;0;0;0;0;0]; 
        % A = [1.0000,0.0100;0,1.0000];
        % B = [0.0001;0.0100];
      % Perform one-time calculations, such as computing constants
      obj.state = obj.initial_state;
      %obj.parameter = DRONE_PARAM("DIATONE","row","mass",0.58);
      % obj.A = A;
      % obj.B = B;
      %obj.P = obj.parameter.get();
      % obj.A = [1.0000,0.0100;0,1.0000];
      % obj.B = [0.0001;0.0100];
    end

    function [next_state] = stepImpl(obj,u,state)
      % Implement algorithm. Calculate y as a function of input u and
      % internal or discrete states.
       %obj.state = obj.A*obj.state(1:2,1) + obj.B*u(1);
       %next_state = obj.state(1:2,1);
      % %A = eye(2);      
      arguments
        obj
        u (4,1) {mustBeNumeric}
        state (13,1) {mustBeNumeric}
      end
       %[~,X] = ode45(@(t,x)obj.A*x + obj.B*u,[0,obj.dt],state);
       [~,X] = ode45(@(t,x)euler_parameter_thrust_torque_physical_parameter_model(x,u,obj.P),[0,obj.dt],state);
       obj.state = X(end,:)';
       next_state = obj.state;
    end

    function resetImpl(obj)
      % Initialize / reset internal or discrete properties
      obj.state = obj.initial_state;
      % obj.A = [1.0000    0.0100;         0    1.0000];
      % obj.B = [   0.0001;    0.0100];
      % obj.A = [0 1;0 0];
      % obj.B = [0;1];
    end

   

    function icon = getIconImpl(obj)
      % Define icon for System block
      icon = mfilename("class"); % Use class name
      % icon = "My System"; % Example: text icon
      % icon = ["My","System"]; % Example: multi-line text icon
      % icon = matlab.system.display.Icon("myicon.jpg"); % Example: image file icon
    end

    function out = getOutputDataTypeImpl(obj)
      % Return data type for each output port
      out = "double";

      % Example: inherit data type from first input port
      % out1 = propagatedInputDataType(obj,1);
      % out2 = propagatedInputDataType(obj,2);
    end

    function out = isOutputComplexImpl(obj)
      % Return true for each output port with complex data
      out = false;
      % Example: inherit complexity from first input port
      % out1 = propagatedInputComplexity(obj,1);
      % out2 = propagatedInputComplexity(obj,2);
    end

    function out = isOutputFixedSizeImpl(obj)
      % Return true for each output port with fixed size
      out = true;

      % Example: inherit fixed-size status from first input port
      %out1 = propagatedInputFixedSize(obj,1);
      %out2 = propagatedInputFixedSize(obj,2);
    end
   function num = getNumInputsImpl(~)
      num = 2;
   end
   function [sz,dt,cp] = getDiscreteStateSpecificationImpl(~,state)
      sz = [13 1];
      dt = "double";
      cp = false;
   end
  end
  methods (Static, Access = protected)
    %% Simulink customization functions
    function header = getHeaderImpl
      % Define header panel for System block dialog
      header = matlab.system.display.Header(mfilename("class"));
    end  
    function sz_1 = getOutputSizeImpl(obj) 
      sz_1 = [13,1] ;
      %sz_1 = propagatedInputSize(obj,1); 
      % sz_2 = propagatedInputSize(obj,2); 
      
   end
  end
end
