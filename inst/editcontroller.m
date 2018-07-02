
graphics_toolkit qt

## Delete it later (Only for debug) -------------------------------------------------------------------------------
##close all 
##clear all
## -------------------------------------------------------------------------------------------------------------------------------

## For now, I am using global variables. It will be modified


global h3

h3.C = h1.C;
##h1.G = zpk([], -30, 100);
##h3.C = zpk([1],[1 -2],1);  # Compensator
##s = tf('s');
##h3.C = 50*(s+3) / (s^ 3-s^ 2+11*s-51);

h3.zpk_idx = [];
h3.zpk = zeros(1, 10);
h3.location = zeros(1, 10);
h3.damp = zeros(1, 10);
h3.freq = zeros(1, 10);

T = evalc('h3.C');
idx = find(T == "y", 1, 'last');
T(idx:idx+2) = "x  ";

h3.zpk_cfreq = "1";
h3.zpk_cdamp = "1";
h3.zpk_crpart = "1";
h3.zpk_cipart = "i";

fig3 = figure;
set (fig3, 'Name','Edit Controller','NumberTitle','off');

## Callbacks Menu 

## Menu tab to display Root Locus Diagram
function call_select(obj)
  global h3
    
  switch ( get (h3.select_compensator, "Value") )   
      case {1}
        disp("C");    
      case {2}
        disp("F");  
  endswitch

endfunction

function dynamics(obj, C)

  global h3
  p2 = uipanel ("title", "Dynamics", "position", [.05 .05 .43 .7]);

  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Type", "fontweight", "bold", "horizontalalignment", "left", "position", [0.05 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Location", "fontweight", "bold", "horizontalalignment", "center", "position", [0.25 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Damping", "fontweight", "bold", "horizontalalignment", "center", "position", [0.50 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Frequency", "fontweight", "bold", "horizontalalignment", "center", "position", [0.75 0.83 .25 .2]);     

  [olpol, olzer, ~, flag] = getZP (h3.C);
  
  np = length(olpol);
  nz = length(olzer);
  N = np+ nz;
  for i=1:N
    yPos = 0.9 - 0.07*i;
    
    if  nz > 0 && i <= np
      if imag(olpol(i)) ~= 0
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Complex Pole", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);  
      else
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Real Pole", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "1", "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);  
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olpol(i))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]);        
      endif
      h3.location(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(olpol(i)), "horizontalalignment", "center", "position", [.25 yPos .25 .07]);  
    endif
    
    if  nz > 0 && i > np
      if imag(olzer(i-np)) ~= 0
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Complex Zero", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);  
      else
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Real Zero", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "1", "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);  
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olzer(i-np))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]);  
      endif
      
      h3.location(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(olzer(i-np)), "horizontalalignment", "center", "position", [.25 yPos .25 .07]);   
    endif
  
  endfor
  
  
  p3 = uipanel ("title", "Edit Select Dynamics", "position", [.52 .05 .43 .7]);

endfunction

function plot_edit_dynamics()
  global h3
  
  p3 = uipanel ("title", "Edit Select Dynamics", "position", [.52 .05 .43 .7]);
  
  [olpol, olzer, ~, flag] = getZP (h3.C);
  
  np = length(olpol);
  nz = length(olzer);
  a = gcbo;
  N = np+ nz;
  for i=1:N
   if (h3.zpk(i) == a && get(h3.zpk(i), "Value") == 1)
     str1 = get(h3.zpk(i), "string");
     str2 =  "Complex Pole";
     if (strcmp(str1, str2))
        h3.lbl_cfreq = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Natural Frequency", "horizontalalignment", "left", "position", [0.1 0.65 .3 .1]);        
        h3.lbl_cdamp = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Damping", "horizontalalignment", "left", "position", [0.1 0.5 .3 .1]);        
        h3.lbl_crpart = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Real Part", "horizontalalignment", "left", "position", [0.1 0.35 .3 .1]);        
        h3.lbl_cipart = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Imaginary Part", "horizontalalignment", "left", "position", [0.1 0.2 .3 .1]);        

        h3.enter_cfreq = uicontrol ("style", "edit", "units", "normalized", "string", h3.zpk_cfreq, "callback", @call_select, "position",  [0.75 0.2 .15 0.05]);        
        h3.enter_cdamp = uicontrol ("style", "edit", "units", "normalized", "string", h3.zpk_cdamp, "callback", @call_select, "position",  [0.75 0.3 .15 0.05]);        
        h3.enter_crpart = uicontrol ("style", "edit", "units", "normalized", "string", h3.zpk_crpart, "callback", @call_select, "position",  [0.75 0.4 .15 0.05]);        
        h3.enter_cipart = uicontrol ("style", "edit", "units", "normalized", "string", h3.zpk_cipart, "callback", @call_select, "position",  [0.75 0.5 .15 0.05]);    
     else
        h3.lbl_rlocation = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Location", "horizontalalignment", "left", "position", [0.1 0.45 .3 .2]);        
        h3.enter_rlocation = uicontrol ("style", "edit", "units", "normalized", "string", "", "callback", @call_select, "position",  [0.7 0.4 .2 0.05]);     
     endif
   else
     set(h3.zpk(i), "Value", 0);
   endif
  endfor

endfunction

function [olpol, olzer, k, flag] = getZP (sys)
## [olpol, olzer, k, flag] = getZP (sys)
##
## Return the poles/zeros/gain and if the "sys". (based on rlocus.m)
## 
## Input:
##      sys: LTI system
##  Outputs:
##      olpol = 1 x number of poles = Array of Poles 
##      olzer = 1 x number of zeros = Array of zeros 
##      k = 1x1 = Gain
##      flag = '1' if sys is a LTI system, otherwise '0' 

  ## Convert the input to a transfer function if necessary
  [num, den] = tfdata (sys, "vector");     # extract numerator/denominator polynomials
  lnum = length (num);
  lden = length (den);
  
  ## equalize length of num, den polynomials
  ## TODO: handle case lnum > lden (non-proper models)
  if (lden < 2)
    ## error ("rlocus: system has no poles");
    flag = 0;
  elseif (lnum < lden)
    num = [zeros(1,lden-lnum), num];       # so that derivative is shortened by one
    flag = 1;
  endif

  olpol = roots (den);
  olzer = roots (num);
  [~,~,k] = zpkdata(sys);
endfunction

## UI Elements 

##p = uipanel ("title", "Controller Editor", "position", [.05 .8 .7 .1]);
p = uipanel ("title", "Compensantor", "position", [.05 .8 .9 .18]);

## Editor List
h3.select_compensator = uicontrol ("parent", p, 
                                "style", "popupmenu",
                                "units", "normalized",
                                "string", {"C",
                                           "F"}, 
                                 "callback", @call_select,
                                "position", [0.05 0.3 .3 .4]);

h3.lbl_equal = uicontrol ("parent", p, 
                                "style", "text",
                               "units", "normalized",
                               "string", " = ",
                               "horizontalalignment", "left",
                                "position", [0.35 0.3 .3 .4]);
 
##h3.lbl_times = uicontrol ("parent", p,  "style", "text", "units", "normalized", "string", " x ------------------", "horizontalalignment", "left", "position", [0.62 0.5 .4 .2]);        
##h3.lbl_num = uicontrol ("parent", p,  "style", "text", "units", "normalized", "string", " NUM ", "horizontalalignment", "center", "position", [0.65 0.6 .18 .4]);       
##h3.lbl_den = uicontrol ("parent", p, "style", "text", "units", "normalized", "string", " DEN ", "horizontalalignment", "center", "position", [0.65 0.1 .18 .4]);            
                            
                            
h3.lbl_num = uicontrol ( "style", "text", "units", "normalized", "string", T(55:end-24), "horizontalalignment", "left", "verticalalignment", "middle","position", [.62 .8 .3 .18]);

## Edit Box
h3.enter_plant = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "",
                               "callback", @call_select,
                                "position",  [.4 .86 .2 .05]);
 
c3 = uicontextmenu (fig3);

h3.m1 = uimenu ("parent",c3, 'label', "'x' Real Pole",           'callback', 'call_add_poles');
h3.m2 = uimenu ("parent",c3, 'label',  "'xx' Complex Pole", 'callback', 'call_add_cpoles');
h3.m3 = uimenu ("parent",c3, 'label',  "'o' Real Zero",          'callback', 'call_add_zeros');
h3.m4 = uimenu ("parent",c3, 'label',  "'oo' Complex Zero", 'callback', 'call_add_czeros');
h3.m5 = uimenu ("parent",c3, 'label', "Integrator",               'callback', 'call_pendig');
h3.m6 = uimenu ("parent",c3, 'label', "Differentiator",          'callback', 'call_pendig');
h3.m7 = uimenu ("parent",c3, 'label',  "Lead",                      'callback', 'call_pendig');
h3.m8 = uimenu ("parent",c3, 'label', "Lag",                         'callback', 'call_pendig');
h3.m9 = uimenu ("parent",c3, 'label', "Notch",                     'callback', 'call_pendig');

% set the context menu for the figure
set (fig3, "uicontextmenu", c3);


set (fig3, "color", get(0, "defaultuicontrolbackgroundcolor"))
set(fig3, 'Visible', 'off');

guidata (gcf, h3)
dynamics(gcf, h3.C);
##call_select (gcf);
         
                
                   

                