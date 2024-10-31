-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- Optional, for arithmetic operations
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Optional, for unsigned operations

entity Ripple_Carry_Adder is
    Port (
        A      : in  STD_LOGIC_VECTOR(3 downto 0); -- First input
        B      : in  STD_LOGIC_VECTOR(3 downto 0); -- Second input
        Sum    : out STD_LOGIC_VECTOR(3 downto 0); -- Sum output
        Carry   : out STD_LOGIC                     -- Carry output
    );
end Ripple_Carry_Adder;

architecture Behavioral of Ripple_Carry_Adder is
    signal x, y, z : STD_LOGIC; -- Intermediate carry signals
begin

    -- Instantiate full adders
    FA1: entity work.full_add port map (A(0), B(0), '0', Sum(0), x);
    FA2: entity work.full_add port map (A(1), B(1), x, Sum(1), y);
    FA3: entity work.full_add port map (A(2), B(2), y, Sum(2), z);
    FA4: entity work.full_add port map (A(3), B(3), z, Sum(3), Carry);

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- Optional
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Optional

entity Ripple_Carry_Adder_tb is
end Ripple_Carry_Adder_tb;

architecture Behavioral of Ripple_Carry_Adder_tb is
    signal A_tb     : STD_LOGIC_VECTOR(3 downto 0);
    signal B_tb     : STD_LOGIC_VECTOR(3 downto 0);
    signal Sum_tb   : STD_LOGIC_VECTOR(3 downto 0);
    signal Carry_tb  : STD_LOGIC;

    -- Component Declaration for the Unit Under Test (UUT)
    component Ripple_Carry_Adder
        Port (
            A     : in  STD_LOGIC_VECTOR(3 downto 0);
            B     : in  STD_LOGIC_VECTOR(3 downto 0);
            Sum   : out STD_LOGIC_VECTOR(3 downto 0);
            Carry : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the UUT
    DUT: Ripple_Carry_Adder port map (A => A_tb, B => B_tb, Sum => Sum_tb, Carry => Carry_tb);

    -- Test process
    process
    begin
        for integer i := 0 to 63 loop
            A_tb <= std_logic_vector(to_unsigned(i, 4));
            B_tb <= std_logic_vector(to_unsigned(i, 4)); -- Just for testing
            wait for 10 ns;
        end loop;
        wait; -- Wait indefinitely
    end process;

    -- Monitoring the outputs
    process
    begin
        wait for 10 ns; -- Initial wait
        while true loop
            report "A=" & integer'image(to_integer(unsigned(A_tb))) &
                   " B=" & integer'image(to_integer(unsigned(B_tb))) &
                   " Sum=" & integer'image(to_integer(unsigned(Sum_tb))) &
                   " Carry=" & std_logic'image(Carry_tb);
            wait for 10 ns; -- Check outputs every 10 ns
        end loop;
    end process;

end Behavioral;