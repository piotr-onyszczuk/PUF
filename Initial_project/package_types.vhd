library IEEE;
use IEEE.STD_LOGIC_1164.all;

package package_types is

type STATUSY is (czekaj, data, parzystosc, stop);
type STATUSES is (ARGUMENTY, WYNIK);
type OPERANDS is (NONE, PLUS, MINUS, RET);
type LICZBA is array(natural range <>) of natural;
type TAB_I is array(natural range <>) of INTEGER;
type TAB_O is array(natural range <>) of OPERANDS;

end package_types;


package body package_types is

 
end package_types;
