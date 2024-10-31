-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity carry_look_ahead_adder is
    Port ( a : in STD_LOGIC_VECTOR(3 downto 0);
           b : in STD_LOGIC_VECTOR(3 downto 0);
           cin : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end carry_look_ahead_adder;

architecture Behavioral of carry_look_ahead_adder is
    signal P : STD_LOGIC_VECTOR(3 downto 0);
    signal G : STD_LOGIC_VECTOR(3 downto 0);
    signal C : STD_LOGIC_VECTOR(4 downto 1);
begin
    -- Generate Propagate (P) and Generate (G) signals
    P(0) <= a(0) xor b(0);
    P(1) <= a(1) xor b(1);
    P(2) <= a(2) xor b(2);
    P(3) <= a(3) xor b(3);
    
    G(0) <= a(0) and b(0);
    G(1) <= a(1) and b(1);
    G(2) <= a(2) and b(2);
    G(3) <= a(3) and b(3);

    -- Calculate carry bits
    C(1) <= G(0) or (P(0) and cin);
    C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and cin);
    C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and cin);
    C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and cin);

    -- Calculate sum bits
    sum(0) <= P(0) xor cin;
    sum(1) <= P(1) xor C(1);
    sum(2) <= P(2) xor C(2);
    sum(3) <= P(3) xor C(3);

    -- Output carry
    Cout <= C(4);
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity carry_look_ahead_adder_tb is
end carry_look_ahead_adder_tb;

architecture Behavioral of carry_look_ahead_adder_tb is
    signal a_tb, b_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal cin_tb : STD_LOGIC;
    signal sum_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal carry_tb : STD_LOGIC;
begin
    -- Instantiate the carry_look_ahead_adder design
    DUT: entity work.carry_look_ahead_adder port map(a => a_tb, b => b_tb, cin => cin_tb, sum => sum_tb, Cout => carry_tb);

    -- Test process
    process
        variable i : integer := 0;
    begin
        for i in 0 to 511 loop
            a_tb <= std_logic_vector(to_unsigned((i / 32) mod 16, 4));    -- Extract 4 bits for a_tb
            b_tb <= std_logic_vector(to_unsigned((i / 2) mod 16, 4));     -- Extract 4 bits for b_tb
            cin_tb <= std_logic'val((i mod 2));                           -- Extract 1 bit for cin_tb
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Monitor the output
    process
    begin
        wait for 1 ns;
        while true loop
            report "A=" & integer'image(to_integer(unsigned(a_tb))) & 
                   " B=" & integer'image(to_integer(unsigned(b_tb))) &
                   " Cin=" & integer'image(to_integer(unsigned(cin_tb))) &
                   " Sum=" & integer'image(to_integer(unsigned(sum_tb))) &
                   " Carry=" & integer'image(to_integer(unsigned(carry_tb)));
            wait for 10 ns;
        end loop;
    end process;
end Behavioral;
