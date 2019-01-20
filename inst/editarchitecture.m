## 16.06.2016 Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>
## editarchitecture
## GSoC 2018: https://eriveltongualter.github.io/GSoC2018/
## Author: Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>

graphics_toolkit qt

set(0, 'currentfigure', 4); 

global h4

function edit_architecture()
  global h4
  if get(h4.b1, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG1); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'F'); set(h4.gp3_identifier2, 'String', 'C'); set(h4.gp3_identifier3, 'String', 'G'); set(h4.gp3_identifier4, 'String', 'H'); set(h4.gp3_identifier5, 'String', '--'); set(h4.gp3_identifier6, 'String', '--'); set(h4.gp3_identifier7, 'String', '--');
    set(h4.gp3_identifier1_edit, 'String', 'F'); set(h4.gp3_identifier2_edit, 'String', 'C'); set(h4.gp3_identifier3_edit, 'String', 'G'); set(h4.gp3_identifier4_edit, 'String', 'H'); set(h4.gp3_identifier5_edit, 'String', '--'); set(h4.gp3_identifier6_edit, 'String', '--'); set(h4.gp3_identifier7_edit, 'String', '--');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '--'); set(h4.gp3_identifier6_edit2, 'String', '--'); set(h4.gp3_identifier7_edit2, 'String', '--');
    h4.set_arch = 1;
  endif
  if get(h4.b2, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG2); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'F'); set(h4.gp3_identifier2, 'String', 'C'); set(h4.gp3_identifier3, 'String', 'G'); set(h4.gp3_identifier4, 'String', 'H'); set(h4.gp3_identifier5, 'String', '--'); set(h4.gp3_identifier6, 'String', '--'); set(h4.gp3_identifier7, 'String', '--');
    set(h4.gp3_identifier1_edit, 'String', 'F'); set(h4.gp3_identifier2_edit, 'String', 'C'); set(h4.gp3_identifier3_edit, 'String', 'G'); set(h4.gp3_identifier4_edit, 'String', 'H'); set(h4.gp3_identifier5_edit, 'String', '--'); set(h4.gp3_identifier6_edit, 'String', '--'); set(h4.gp3_identifier7_edit, 'String', '--');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '--'); set(h4.gp3_identifier6_edit2, 'String', '--'); set(h4.gp3_identifier7_edit2, 'String', '--');
    h4.set_arch = 2;
  endif
  if get(h4.b3, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG3); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'F'); set(h4.gp3_identifier2, 'String', 'C'); set(h4.gp3_identifier3, 'String', 'G'); set(h4.gp3_identifier4, 'String', 'H'); set(h4.gp3_identifier5, 'String', '--'); set(h4.gp3_identifier6, 'String', '--'); set(h4.gp3_identifier7, 'String', '--');
    set(h4.gp3_identifier1_edit, 'String', 'F'); set(h4.gp3_identifier2_edit, 'String', 'C'); set(h4.gp3_identifier3_edit, 'String', 'G'); set(h4.gp3_identifier4_edit, 'String', 'H'); set(h4.gp3_identifier5_edit, 'String', '--'); set(h4.gp3_identifier6_edit, 'String', '--'); set(h4.gp3_identifier7_edit, 'String', '--');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '--'); set(h4.gp3_identifier6_edit2, 'String', '--'); set(h4.gp3_identifier7_edit2, 'String', '--');
    h4.set_arch = 3;
  endif
  if get(h4.b4, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG4); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'C1'); set(h4.gp3_identifier2, 'String', 'C2'); set(h4.gp3_identifier3, 'String', 'G'); set(h4.gp3_identifier4, 'String', 'H'); set(h4.gp3_identifier5, 'String', '--'); set(h4.gp3_identifier6, 'String', '--'); set(h4.gp3_identifier7, 'String', '--');
    set(h4.gp3_identifier1_edit, 'String', 'C1'); set(h4.gp3_identifier2_edit, 'String', 'C2'); set(h4.gp3_identifier3_edit, 'String', 'G'); set(h4.gp3_identifier4_edit, 'String', 'H'); set(h4.gp3_identifier5_edit, 'String', '--'); set(h4.gp3_identifier6_edit, 'String', '--'); set(h4.gp3_identifier7_edit, 'String', '--');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '--'); set(h4.gp3_identifier6_edit2, 'String', '--'); set(h4.gp3_identifier7_edit2, 'String', '--');
    h4.set_arch = 4;
  endif
  if get(h4.b5, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG5); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'F'); set(h4.gp3_identifier2, 'String', 'C'); set(h4.gp3_identifier3, 'String', 'G1'); set(h4.gp3_identifier4, 'String', 'G2'); set(h4.gp3_identifier5, 'String', 'Gd'); set(h4.gp3_identifier6, 'String', '--'); set(h4.gp3_identifier7, 'String', '--');
    set(h4.gp3_identifier1_edit, 'String', 'F'); set(h4.gp3_identifier2_edit, 'String', 'C'); set(h4.gp3_identifier3_edit, 'String', 'G1'); set(h4.gp3_identifier4_edit, 'String', 'G2'); set(h4.gp3_identifier5_edit, 'String', 'Gd'); set(h4.gp3_identifier6_edit, 'String', '--'); set(h4.gp3_identifier7_edit, 'String', '--');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier6_edit2, 'String', ''); set(h4.gp3_identifier7_edit2, 'String', '--');
    h4.set_arch = 5;
  endif
  if get(h4.b6, 'value')
    axes(h4.ax7);  image(h4.img.sisoCONFIG6); axis off; axis image;
    set(h4.gp3_identifier1, 'String', 'F'); set(h4.gp3_identifier2, 'String', 'C1'); set(h4.gp3_identifier3, 'String', 'C2'); set(h4.gp3_identifier4, 'String', 'G1'); set(h4.gp3_identifier5, 'String', 'G2'); set(h4.gp3_identifier6, 'String', 'H1'); set(h4.gp3_identifier7, 'String', 'H2');
    set(h4.gp3_identifier1_edit, 'String', 'F'); set(h4.gp3_identifier2_edit, 'String', 'C1'); set(h4.gp3_identifier3_edit, 'String', 'C2'); set(h4.gp3_identifier4_edit, 'String', 'G1'); set(h4.gp3_identifier5_edit, 'String', 'G2'); set(h4.gp3_identifier6_edit, 'String', 'H1'); set(h4.gp3_identifier7_edit, 'String', 'H2');
    set(h4.gp3_identifier1_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier2_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier3_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier4_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier5_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier6_edit2, 'String', '<1x1 zpk>'); set(h4.gp3_identifier7_edit2, 'String', '<1x1 zpk>');
    h4.set_arch = 6;
  endif
endfunction

function visibleoff_architecture();
  set(4, 'Visible', 'off');
endfunction

function call_ok
##  try
##    h1.G = eval(v);
##    h1.C = zpk([],[],1); 
##  catch
##    set(h1.lbl_plant, 'String', 'Transfer function : ... invalid! Try again  ...');
##  end_try_catch
endfunction

function call_cancell
  str1 = questdlg('Are you sure you want to leave this page without save?');
  str2 =  "Yes";
  str3 =  "No";
  if (strcmp(str1, str2))  
    set(4, 'Visible', 'off');
  endif
  if (strcmp(str1, str2))  
##    Do nothing, just leave the dialog box
  endif
endfunction

function call_help
  f = helpdlg('Acess the following website for more information: https://eriveltongualter.github.io/GSoC2018/pages/documentation.html' ,'Help');
endfunction

set(fig4, 'resize', 'off');
                              
h4.ax7 = axes ("position", [0.25 0.35 0.75 0.8]);

h4.ax6 = axes ("position", [0.05 0.10 0.2 0.1]);
h4.ax5 = axes ("position", [0.05 0.25 0.2 0.1]);
h4.ax4 = axes ("position", [0.05 0.40 0.2 0.1]);
h4.ax3 = axes ("position", [0.05 0.55 0.2 0.1]);
h4.ax2 = axes ("position", [0.05 0.70 0.2 0.1]);
h4.ax1 = axes ("position", [0.05 0.85 0.2 0.1]);

sisoconfig1 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig1Thumb.png'));
sisoconfig2 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig2Thumb.png'));
sisoconfig3 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig3Thumb.png'));
sisoconfig4 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig4Thumb.png'));
sisoconfig5 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig5Thumb.png'));
sisoconfig6 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/SISOConfig6Thumb.png'));

h4.img.sisoCONFIG1 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config1.png'));
h4.img.sisoCONFIG2 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config2.png'));
h4.img.sisoCONFIG3 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config3.png'));
h4.img.sisoCONFIG4 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config4.png'));
h4.img.sisoCONFIG5 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config5.png'));
h4.img.sisoCONFIG6 = im2double(imread('/home/erivelton/octave/control-3.1.0/images/Config6.png'));
        
axes(h4.ax1);  image(sisoconfig1); axis off; axis image;
axes(h4.ax2);  image(sisoconfig2); axis off; axis image;
axes(h4.ax3);  image(sisoconfig3); axis off; axis image;
axes(h4.ax4);  image(sisoconfig4); axis off; axis image;
axes(h4.ax5);  image(sisoconfig5); axis off; axis image;
axes(h4.ax6);  image(sisoconfig6); axis off; axis image;

axes(h4.ax7);  image(h4.img.sisoCONFIG1); axis off; axis image;

% create a button group
gp = uibuttongroup (fig4, "Position", [ 0 0 0.05 1]);
% create a buttons in the group
h4.b6 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.10 0.75 0.1], 'callback', 'edit_architecture');
h4.b5 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.25 0.75 0.1], 'callback', 'edit_architecture');
h4.b4 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.40 0.75 0.1], 'callback', 'edit_architecture');
h4.b3 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.55 0.75 0.1], 'callback', 'edit_architecture');
h4.b2 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.70 0.75 0.1], 'callback', 'edit_architecture');
h4.b1 = uicontrol (gp, "style", "radiobutton","units", "normalized","Position", [0.25 0.85 0.75 0.1], 'callback', 'edit_architecture');

p4 = uipanel ("title", "Blocks", "position", [.25 .1 .75 .45]);
gp2 = uibuttongroup (p4, "Position", [ 0 0.8 1 0.2]);
h4.gp2_title1 = uicontrol (gp2,"style", "text", "units", "normalized", "fontweight", "bold", "string", "Identifier", "horizontalalignment", "left", "position", [0 0 0.18 1]);
h4.gp2_title2 = uicontrol (gp2,"style", "text", "units", "normalized", "fontweight", "bold", "string", "Block Name", "horizontalalignment", "left", "position", [0.18 0 0.21 1]);
h4.gp2_title3 = uicontrol (gp2,"style", "text", "units", "normalized", "fontweight", "bold", "string", "Value", "horizontalalignment", "left", "position", [0.42 0 0.2 1]);

gp3 = uibuttongroup (p4, "Position", [ 0 0 1 0.8]);
h4.gp3_identifier1 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "F", "horizontalalignment", "left", "position", [0.05 0.9 0.04 .1]);
h4.gp3_identifier2 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "C", "horizontalalignment", "left", "position", [0.05 0.75 0.04 .1]);
h4.gp3_identifier3 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "G", "horizontalalignment", "left", "position", [0.05 0.60 0.04 .1]);
h4.gp3_identifier4 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "H", "horizontalalignment", "left", "position", [0.05 0.45 0.04 .1]);
h4.gp3_identifier5 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "", "horizontalalignment", "left", "position", [0.05 0.30 0.04 .1]);
h4.gp3_identifier6 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "", "horizontalalignment", "left", "position", [0.05 0.15 0.04 .1]);
h4.gp3_identifier7 = uicontrol (gp3,"style", "text", "units", "normalized", "string", "", "horizontalalignment", "left", "position", [0.05 0.0 0.04 .1]);

h4.gp3_identifier1_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "F", "horizontalalignment", "center", "position", [0.18 0.9 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier2_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "C", "horizontalalignment", "center", "position", [0.18 0.75 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier3_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "G", "horizontalalignment", "center", "position", [0.18 0.60 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier4_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "H", "horizontalalignment", "center", "position", [0.18 0.45 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier5_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.18 0.30 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier6_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.18 0.15 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier7_edit = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.18 0.0 0.2 .1], 'backgroundcolor', 'white');

h4.gp3_identifier1_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "<1x1 zpk>", "horizontalalignment", "center", "position", [0.42 0.9 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier2_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "<1x1 zpk>", "horizontalalignment", "center", "position", [0.42 0.75 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier3_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "<1x1 zpk>", "horizontalalignment", "center", "position", [0.42 0.60 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier4_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "<1x1 zpk>", "horizontalalignment", "center", "position", [0.42 0.45 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier5_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.42 0.30 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier6_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.42 0.15 0.2 .1], 'backgroundcolor', 'white');
h4.gp3_identifier7_edit2 = uicontrol (gp3,"style", "edit", "units", "normalized", "string", "--", "horizontalalignment", "center", "position", [0.42 0.0 0.2 .1], 'backgroundcolor', 'white');

h4.btn_savecontroller = uicontrol ("style", "pushbutton", "units", "normalized", "string", "OK", "position", [0.66 0.01 0.1 0.06],'callback','call_ok');  
h4.btn_savecontroller = uicontrol ("style", "pushbutton", "units", "normalized", "string", "Cancel", "position", [0.78 0.01 0.1 0.06],'callback', 'call_cancell');   
h4.btn_savecontroller = uicontrol ("style", "pushbutton", "units", "normalized", "string", "Help", "position", [0.9 0.01 0.1 0.06],'callback', 'call_help');  
                                
set (fig4, "color", get(0, "defaultuicontrolbackgroundcolor"));
set(fig4,'CloseRequestFcn','visibleoff_architecture');

