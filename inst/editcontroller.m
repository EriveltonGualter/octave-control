## 16.06.2016 Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>
## editcontroller
## GSoC 2018: https://eriveltongualter.github.io/GSoC2018/
## Author: Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>


graphics_toolkit qt

global h3

set(0, 'currentfigure', 3); 

h3.sys = h1.C;
##h1.G = zpk([], -30, 100);
##h3.sys = zpk([1],[1 -2],1);  # Compensator
##s = tf('s');
##h3.sys = 50*(s+3) / (s^ 3-s^ 2+11*s-51);

[~, ~, k, ~] = getZP (h3.sys);
t = h3.sys/k;
T = evalc('t'); idx = find(T == "y", 1, 'last'); T(idx:idx+2) = "x  ";
  
h3.zpk_idx = [];
maxn = 15;
h3.zpk = zeros(1, maxn);
h3.location = zeros(1, maxn);
h3.damp = zeros(1, maxn);
h3.freq = zeros(1, maxn);

##h3.zpk_cfreq = "1";
##h3.zpk_cdamp = "1";
##h3.zpk_crpart = "1";
##h3.zpk_cipart = "i";

## Callbacks Menu 

## Menu tab to display Root Locus Diagram
function call_select(obj)
  set(0, 'currentfigure', 3); 
  global h1 h3
    
  switch ( get (h3.select_compensator, "Value") )   
      case {1}
        h3.sys = h1.C;
      case {2}
        h3.sys = h1.F;
  endswitch
  dynamics()
endfunction

function dynamics()

  global h3
  set(0, 'currentfigure', 3); 
  p2 = uipanel ("title", "Dynamics", "position", [.05 .05 .43 .7]);

  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Type", "fontweight", "bold", "horizontalalignment", "left", "position", [0.05 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Location", "fontweight", "bold", "horizontalalignment", "center", "position", [0.25 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Damping", "fontweight", "bold", "horizontalalignment", "center", "position", [0.50 0.83 .25 .2]);        
  h3.lbl_title1 = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "Frequency", "fontweight", "bold", "horizontalalignment", "center", "position", [0.75 0.83 .25 .2]);     

  [olpol, olzer, k, flag] = getZP (h3.sys);
  set(h3.gain_box, "String", num2str(k));
                                
  np = length(olpol);
  nz = length(olzer);
  N = np+ nz;
  for i=1:N
    yPos = 0.9 - 0.07*i;
    
    if  np > 0 && i <= np
      if imag(olpol(i)) ~= 0
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Complex Pole", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);  
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olpol(i))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]); 
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(cos(angle(olpol(i)))), "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);
      else
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Real Pole", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olpol(i))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]);        
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "1", "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);  
      endif
      h3.location(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(olpol(i)), "horizontalalignment", "center", "position", [.25 yPos .25 .07]);  
      h3.real(i) = real(olpol(i));
      h3.imag(i) = imag(olpol(i));
    endif
    
    if  nz > 0 && i > np
      if imag(olzer(i-np)) ~= 0
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Complex Zero", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);  
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olzer(i-np))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]);  
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(cos(angle(olzer(i-np)))), "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);
      else
        h3.zpk(i)  = uicontrol ("parent", p2,  "style", "radiobutton", "units", "normalized", "string", "Real Zero", "callback", @plot_edit_dynamics, "horizontalalignment", "left", "position", [0 yPos .25 .07]);
        h3.freq(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(abs(olzer(i-np))), "horizontalalignment", "center", "position", [0.75 yPos .25 .07]);  
        h3.damp(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", "1", "horizontalalignment", "center", "position", [0.5 yPos .25 .07]);  
      endif  
      h3.location(i)  = uicontrol ("parent", p2,  "style", "text", "units", "normalized", "string", num2str(olzer(i-np)), "horizontalalignment", "center", "position", [.25 yPos .25 .07]);   
      h3.real(i) = real(olzer(i-np));
      h3.imag(i) = imag(olzer(i-np));
    endif
  
  endfor
  
  ## Show Tranfers funciton
  [~, ~, k, ~] = getZP (h3.sys);
  t = h3.sys/k;
  T = evalc('t'); idx = find(T == "y", 1, 'last'); T(idx:idx+2) = "x  ";
  h3.lbl_num = uicontrol ( "style", "text", "units", "normalized", "string", T(55:end-24), "horizontalalignment", "left", "verticalalignment", "middle","position", [.62 .8 .3 .18]);
  
  p3 = uipanel ("title", "Edit Select Dynamics", "position", [.52 .05 .43 .7]);
  plot_edit_dynamics();
endfunction

function plot_edit_dynamics()
  global h3
  set(0, 'currentfigure', 3); 
  p3 = uipanel ("title", "Edit Select Dynamics", "position", [.52 .05 .43 .7]);
  
  [olpol, olzer, ~, flag] = getZP (h3.sys);
  
  np = length(olpol);
  nz = length(olzer);
  a = gcbo;
  N = np+ nz;
  select_flag = 1;
  for i=1:N
   if (h3.zpk(i) == a && get(h3.zpk(i), "Value") == 1)
     h3.currentzpk = i;
     str1 = get(h3.zpk(i), "string");
     str2 =  "Complex Pole";
     str3=  "Complex Zero";
     if (strcmp(str1, str2) || strcmp(str1, str3))
       zpk_cfreq = get(h3.freq(i), "String");
       zpk_cdamp = get(h3.damp(i), "String");
       zpk_crpart = num2str(h3.real(i));
       zpk_cipart = num2str(h3.imag(i));
       
       h3.lbl_cfreq = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Natural Frequency", "horizontalalignment", "left", "position", [0.1 0.65 .3 .1]);        
       h3.lbl_cdamp = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Damping", "horizontalalignment", "left", "position", [0.1 0.5 .3 .1]);        
       h3.lbl_crpart = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Real Part", "horizontalalignment", "left", "position", [0.1 0.35 .3 .1]);        
       h3.lbl_cipart = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Imaginary Part", "horizontalalignment", "left", "position", [0.1 0.2 .3 .1]);        

       h3.enter_cfreq = uicontrol ("style", "edit", "units", "normalized", "string", zpk_cfreq, "callback", @call_update_dynamic, "position",  [0.75 0.5 .15 0.05], 'backgroundcolor', 'white');
       h3.enter_cdamp = uicontrol ("style", "edit", "units", "normalized", "string", zpk_cdamp, "callback", @call_update_dynamic, "position",  [0.75 0.4 .15 0.05], 'backgroundcolor', 'white');
       h3.enter_crpart = uicontrol ("style", "edit", "units", "normalized", "string", zpk_crpart, "callback", @call_update_dynamic, "position",  [0.75 0.3 .15 0.05], 'backgroundcolor', 'white');
       h3.enter_cipart = uicontrol ("style", "edit", "units", "normalized", "string", zpk_cipart, "callback", @call_update_dynamic, "position",  [0.75 0.2 .15 0.05], 'backgroundcolor', 'white');
     else
       h3.lbl_rlocation = uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Location", "horizontalalignment", "left", "position", [0.1 0.45 .3 .2]);        
       h3.enter_rlocation = uicontrol ("style", "edit", "units", "normalized", "string", get(h3.location(i), "String"), "callback", @call_update_dynamic, "position",  [0.7 0.4 .2 0.05]);     
     endif
     select_flag = 0;
   else
     set(h3.zpk(i), "Value", 0);
   endif
  endfor
  if select_flag == 1
    uicontrol ("parent", p3,  "style", "text", "units", "normalized", "string", "Select a single row to edit values", "horizontalalignment", "center", "position", [0.1 0.45 .8 .1]);   
  endif
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
  flag = 0;
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

function call_update_gain()
  global h1 h2 h3
  
  [z,p,~] = zpkdata(h1.C);
  k = get( h3.gain_box, "String");
 
  h1.C = zpk(z,p,str2num(k));
  h3.sys = h1.C; 
  
  if (isaxes(h2.axrl) == 1)   
    axes(h2.axrl);
    plotrlocus();
  endif
  
  if (isaxes(h2.axny) == 1)
    axes(h2.axny);
    nyquist(h1.G);
  endif
  
  if (isaxes(h2.axbm) == 1)
    axes(h2.axbm);
    plotbode();
  endif

  dynamics();
endfunction

function call_update_dynamic()
##  disp('DEB: Update location');

  global h1 h2 h3
     
  [olpol, olzer, k,~] = getZP (h3.sys);
  
  np = length(olpol);
  nz = length(olzer);
  ii = h3.currentzpk;
      
  imag_flag = 0;
  if  np > 0 && ii <= np
    if imag(olpol(ii)) ~= 0
      imag_flag = 1;
    else
      olpol(ii) = str2num(get(h3.enter_rlocation, "String"));
    endif
  endif

  if  nz > 0 && ii > np
    if imag(olzer(ii-np)) ~= 0
      imag_flag = 1;
    else
      olzer(ii-np) = str2num(get(h3.enter_rlocation, "String"));
    endif
  endif
  
  if (imag_flag)
    poles(1,:) = [real(olpol)' real(olzer)'];
    poles(2,:) = [imag(olpol)' imag(olzer)'];

    idx = find(poles(2,:) == h3.imag(ii), 1, 'last')
    idxc = find(poles(2,:) == -1*h3.imag(ii), 1, 'last')

    c(1) = str2num(get(h3.enter_crpart, "String"));
    c(2) = str2num(get(h3.enter_cipart, "String"));

    poles(:, idx) = [c(1); c(2)];
    poles(:, idxc) = [c(1); -c(2)];

    olpol = poles(1, 1:length(olpol)) + poles(2, 1:length(olpol))*i;
    olzer = poles(1, length(olpol)+1:end) + poles(2, length(olpol)+1:end)*i;
  endif
  
  h1.C = zpk (olzer, olpol,k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_rpole()
  global h1 h3
  
  [olpol, olzer,k,~] = getZP (h1.C);
  
  c = -1;  
  olpol = [olpol; c(1)];
  h1.C = zpk (olzer, olpol',k);    
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_cpole()    
  global h1 h3
  [olpol, olzer,k,~] = getZP (h1.C);
  c = [-1 -1];
  
  olpol = [olpol; c(1)+i*c(2); c(1)-i*c(2)];
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_rzero()
  global h1 h3
  [olpol, olzer,k,~] = getZP (h1.C);
  c = -1;
  
  olzer = [olzer; c(1)];
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_czero()
  global h1 h3
  [olpol, olzer,k,~] = getZP (h1.C);
  c = [-1 -1];

  olzer = [olzer; c(1)+i*c(2); c(1)-i*c(2)];
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_integrator()
  global h1 h3
  
  [olpol, olzer,k,~] = getZP (h1.C);
  
  c = 0  
  olpol = [olpol; c(1)];
  h1.C = zpk (olzer, olpol',k);    
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_differentiator()
  global h1 h3
  [olpol, olzer,k,~] = getZP (h1.C);
  c = 0;
  
  olzer = [olzer; c(1)];
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_pending()
  disp('Pending feature');
endfunction

function delete_pz()
  global h1 h3
  set(0, 'currentfigure', 3); 
  
  [olpol, olzer, k, ~] = getZP (h3.sys);
  poles(1,:) = [real(olpol)' real(olzer)'];
  poles(2,:) = [imag(olpol)' imag(olzer)'];
  
  np = length(olpol);
  nz = length(olzer);
  a = gcbo;
  N = np+ nz;
  select_flag = 1;
  idx = [];
  for i=1:N
   if (get(h3.zpk(i), "Value") == 1)
     idx = i;
     h3.currentzpk = i;
     str1 = get(h3.zpk(i), "string");
     str2 =  "Complex Pole";
     str3=  "Complex Zero";
     if (strcmp(str1, str2) || strcmp(str1, str3)) ## Complex

     else ## Real
     
     endif
   else
     set(h3.zpk(i), "Value", 0);
   endif
  endfor

  if abs(poles(2, idx)) > 0
    idxc = find(poles(2,:) == -1*poles(2, idx), 1, 'last');      
    poles(:, idx) = [];
    poles(:, idxc) = [];
    lastpol = length(olpol);
    if idx <= length(olpol)
      olpol = poles(1, 1:lastpol-2) + poles(2, 1:lastpol-2)*i;
      olzer = poles(1, lastpol-1:end) + poles(2, lastpol-1:end)*i;
    else
      olpol = poles(1, 1:lastpol) + poles(2, 1:lastpol)*i;
      olzer = poles(1, lastpol+1:end) + poles(2, lastpol+1:end)*i;
    endif
  else
    poles(:,idx) = [];
    lastpol = length(olpol);
    if idx <= length(olpol)
      olpol = poles(1, 1:lastpol-1) + poles(2, 1:lastpol-1)*i;
      olzer = poles(1, lastpol:end) + poles(2, lastpol:end)*i;
    else
      olpol = poles(1, 1:lastpol) + poles(2, 1:lastpol)*i;
      olzer = poles(1, lastpol+1:end) + poles(2, lastpol+1:end)*i;
    endif
  endif
    
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function visibleoff_controller();
  set(3, 'Visible', 'off');
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
h3.gain_box = uicontrol ("style", "edit",  "units", "normalized", "string", "", "callback", @call_update_gain, "position",  [.4 .86 .2 .05], 'backgroundcolor', 'white');
 
c3 = uicontextmenu (fig3);

h3.menu1 = uimenu ("parent",c3, 'label', "Add Pole/Zero ...");
h3.menu2 = uimenu ("parent",c3, 'label', "Delete Pole/Zero ...", 'callback','delete_pz');

h3.m1 = uimenu (h3.menu1, 'label', "'x' Real Pole",'callback', 'add_rpole');
h3.m2 = uimenu (h3.menu1, 'label',  "'xx' Complex Pole",'callback', 'add_cpole');
h3.m3 = uimenu (h3.menu1, 'label',  "'o' Real Zero",'callback', 'add_rzero');
h3.m4 = uimenu (h3.menu1, 'label',  "'oo' Complex Zero",'callback', 'add_czero');
h3.m5 = uimenu (h3.menu1, 'label', "Integrator",'callback', 'add_integrator');
h3.m6 = uimenu (h3.menu1, 'label', "Differentiator",'callback', 'add_differentiator');
h3.m7 = uimenu (h3.menu1, 'label',  "Lead",'callback', 'add_pending');
h3.m8 = uimenu (h3.menu1, 'label', "Lag",'callback', 'add_pending');
h3.m9 = uimenu (h3.menu1, 'label', "Notch",'callback', 'add_pending');
##h3.m1 = uimenu ("parent",c3, 'label', "'x' Real Pole",           'callback', 'call_add_poles');
##h3.m2 = uimenu ("parent",c3, 'label',  "'xx' Complex Pole", 'callback', 'call_add_cpoles');
##h3.m3 = uimenu ("parent",c3, 'label',  "'o' Real Zero",          'callback', 'call_add_zeros');
##h3.m4 = uimenu ("parent",c3, 'label',  "'oo' Complex Zero", 'callback', 'call_add_czeros');
##h3.m5 = uimenu ("parent",c3, 'label', "Integrator",               'callback', 'call_pendig');
##h3.m6 = uimenu ("parent",c3, 'label', "Differentiator",          'callback', 'call_pendig');
##h3.m7 = uimenu ("parent",c3, 'label',  "Lead",                      'callback', 'call_pendig');
##h3.m8 = uimenu ("parent",c3, 'label', "Lag",                         'callback', 'call_pendig');
##h3.m9 = uimenu ("parent",c3, 'label', "Notch",                     'callback', 'call_pendig');

% set the context menu for the figure
set (fig3, "uicontextmenu", c3);

set(fig3, "color", get(0, "defaultuicontrolbackgroundcolor"))
set(fig3, 'Visible', 'off');
set(fig3,'CloseRequestFcn','visibleoff_controller');
 
guidata (gcf, h3)
dynamics(gcf, h3.sys);
##call_select (gcf);
         
                
                   

                
