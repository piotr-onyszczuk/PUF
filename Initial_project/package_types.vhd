library IEEE;
use IEEE.STD_LOGIC_1164.all;

package package_types is

type STATUSY is (czekaj, data, parzystosc, stop);
type STATUSES is (CZEKAJ, LICZBA_1, LICZBA_2, WYNIK);
type OPERANDS is (PLUS, MINUS, NONE, RET);
type LICZBA is array(natural range <>) of natural;

end package_types;


package body package_types is

 
end package_types;
