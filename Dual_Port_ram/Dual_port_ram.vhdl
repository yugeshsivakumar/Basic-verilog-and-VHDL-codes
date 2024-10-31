-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dual_port_ram is
    Port ( clk : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR(7 downto 0);
           Dout : out STD_LOGIC_VECTOR(7 downto 0);
           wr_en : in STD_LOGIC;
           wr_addr : in STD_LOGIC_VECTOR(3 downto 0);
           rd_En : in STD_LOGIC;
           rd_addr : in STD_LOGIC_VECTOR(3 downto 0));
end dual_port_ram;

architecture Behavioral of dual_port_ram is
    type ram_type is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    signal Mem : ram_type := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                Mem(to_integer(unsigned(wr_addr))) <= Din;
            end if;
            if rd_En = '1' then
                Dout <= Mem(to_integer(unsigned(rd_addr)));
            end if;
        end if;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dual_port_ram_tb is
end dual_port_ram_tb;

architecture Behavioral of dual_port_ram_tb is
    signal din_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal wr_addr_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal rd_addr_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal wr_en_tb, rd_en_tb, clk_tb : STD_LOGIC;
    signal dout_tb : STD_LOGIC_VECTOR(7 downto 0);

    -- Instantiate the dual_port_ram
    component dual_port_ram
        Port ( clk : in STD_LOGIC;
               Din : in STD_LOGIC_VECTOR(7 downto 0);
               Dout : out STD_LOGIC_VECTOR(7 downto 0);
               wr_en : in STD_LOGIC;
               wr_addr : in STD_LOGIC_VECTOR(3 downto 0);
               rd_En : in STD_LOGIC;
               rd_addr : in STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- Instantiate DUT
    DUT: dual_port_ram port map(
        clk => clk_tb,
        Din => din_tb,
        Dout => dout_tb,
        wr_en => wr_en_tb,
        wr_addr => wr_addr_tb,
        rd_En => rd_en_tb,
        rd_addr => rd_addr_tb
    );

    -- Clock generation process
    process
    begin
        clk_tb <= '1';
        wait for 5 ns;
        clk_tb <= '0';
        wait for 5 ns;
    end process;

    -- Initialize signals task
    procedure initialize is
    begin
        din_tb <= (others => '0');
        wr_en_tb <= '0';
        rd_en_tb <= '0';
        wr_addr_tb <= (others => '0');
        rd_addr_tb <= (others => '0');
    end procedure;

    -- Write operation task
    procedure write_operation(signal addr : in STD_LOGIC_VECTOR(3 downto 0);
                              signal data : in STD_LOGIC_VECTOR(7 downto 0)) is
    begin
        wr_en_tb <= '1';
        wr_addr_tb <= addr;
        din_tb <= data;
        wait until clk_tb = '0';
        wr_en_tb <= '0';
    end procedure;

    -- Read operation task
    procedure read_operation(signal addr : in STD_LOGIC_VECTOR(3 downto 0)) is
    begin
        rd_en_tb <= '1';
        rd_addr_tb <= addr;
        wait until clk_tb = '0';
        rd_en_tb <= '0';
    end procedure;

begin
    -- Test process
    process
        variable i : integer;
    begin
        initialize;
        wait for 10 ns;

        -- Write to all addresses
        for i in 0 to 15 loop
            write_operation(std_logic_vector(to_unsigned(i, 4)), std_logic_vector(to_unsigned(i, 8)));
            wait for 10 ns;
        end loop;

        -- Read from all addresses
        for i in 0 to 15 loop
            read_operation(std_logic_vector(to_unsigned(i, 4)));
            wait for 10 ns;
        end loop;

        wait;
    end process;
end Behavioral;