## Copyright (C) 2018 erivelton
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {} sisotool (@var{G}) 
## specifies the plant model G to be used in the SISO Tool.
##    Here G is any linear model created with TF, ZPK, or SS.
##
## @deftypefn {Function File} {} sisotool (@var{G, C, H, F}) 
## further specify values for the
##    feedback compensator C, sensor H, and prefilter F.  By default,
##    C, H, and F are all unit gains.
##
## @deftypefn {Function File} {} sisotool (@var{..., VIEWS}) 
##specifies the initial set of views for graphically editing C.  
##You can set VIEWS to any of the
##    following strings or combination of strings: 
##
##        'rlocus'      Root locus plot
##
##        'bode'        Bode diagram of the open-loop response
##
##        'nichols'     Nichols plot of the open-loop response
##
## @strong{Block Diagram}
## @example
## @group
##    r -->[ F ]-->O--->[ C ]--->[ G ]----+---> y
##               - |                      |
##                 +-------[ H ]----------+
##
## @end group
## @end example
##
##Examples:
##
## @example
## @group
## octave:1> sisotool( zpk(-5,[-1 -2 -3 -4],6) );
## @end group
## @end example
##
##opens a SISO Design Tool for G = zpk(-5,[-1 -2 -3 -4],6) 
##    and the open loop CGH.
##
## @example
## @group
##sisotool({'nichols','bode'})
## @end group
## @end example
##
##opens a SISO Design Tool showing the Nichols plot and Bode diagrams
##    for the open loop CGH.
##
## @seealso{tf, zpk, ss, rlocus, nyquist, bode}
## @end deftypefn
## @end deftypefn
## @end deftypefn

## Author: Erivelton Gualter <erivelton.gualter@gmail.com>
## GSoC 2018: https://eriveltongualter.github.io/GSoC2018/
## Created: 2018

function sisotool (varargin)
  nsys = 0;
  for i=1:nargin
    if (isa (varargin{i}, "lti"))
      nsys = nsys + 1;
    endif
  endfor
  
  global h1
  
  if (nsys == 1)
    h1.G = varargin{1};
  elseif (nsys == 2)
    h1.G = varargin{1};    h1.C = varargin{2};
  elseif (nsys == 3)
    h1.G = varargin{1};    h1.C = varargin{2};    h1.H = varargin{3};
  elseif (nsys == 4)
    h1.G = varargin{1};    h1.C = varargin{2};    h1.H = varargin{3};    h1.F = varargin{4};
  endif

  ndigrams = (nargin-nsys);
  if nargin > nsys
    if (ndigrams == 3)
      h1.diag{1,1} = varargin{nsys+1};
      h1.diag{1,2} = varargin{nsys+2};
      h1.diag{1,3} = varargin{nsys+3};
    elseif ((nargin-nsys) == 2)
      h1.diag{1,1} = varargin{nsys+1};
      h1.diag{1,2} = varargin{nsys+2};
    elseif ((nargin-nsys) == 1)
       h1.diag{1,1} = varargin{nsys+1};
    endif
  endif
  
  GUI_sisotool
endfunction
