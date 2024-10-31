-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(7 downto 0);
           we : in STD_LOGIC;
           re : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(7 downto 0);
           full : out STD_LOGIC;
           empty : out STD_LOGIC);
end fifo;

architecture Behavioral of fifo is
    constant data_width : integer := 8;
    constant address_width : integer := 4;
    constant ram_depth : integer := 16;

    signal wr_pointer : STD_LOGIC_VECTOR(address_width-1 downto 0) := (others => '0');
    signal rd_pointer : STD_LOGIC_VECTOR(address_width-1 downto 0) := (others => '0');
    signal status_count : STD_LOGIC_VECTOR(address_width downto 0) := (others => '0');

    signal data_ram : STD_LOGIC_VECTOR(data_width-1 downto 0);

    component dual_port_ram
        Port ( clk : in STD_LOGIC;
               Din : in STD_LOGIC_VECTOR(7 downto 0);
               wr_en : in STD_LOGIC;
               wr_addr : in STD_LOGIC_VECTOR(3 downto 0);
               rd_En : in STD_LOGIC;
               rd_addr : in STD_LOGIC_VECTOR(3 downto 0);
               Dout : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
begin
    -- Instantiate dual port RAM
    ram_inst : dual_port_ram
        port map (
            clk => clk,
            Din => data_in,
            wr_en => we,
            wr_addr => wr_pointer,
            rd_En => re,
            rd_addr => rd_pointer,
            Dout => data_ram
        );

    -- Read pointer
    process (clk, rst)
    begin
        if rst = '1' then
            rd_pointer <= (others => '0');
        elsif rising_edge(clk) then
            if re = '1' then
                rd_pointer <= std_logic_vector(unsigned(rd_pointer) + 1);
            end if;
        end if;
    end process;

    -- Write pointer
    process (clk, rst)
    begin
        if rst = '1' then
            wr_pointer <= (others => '0');
        elsif rising_edge(clk) then
            if we = '1' then
                wr_pointer <= std_logic_vector(unsigned(wr_pointer) + 1);
            end if;
        end if;
    end process;

    -- Status counter for full and empty flags
    process (clk, rst)
    begin
        if rst = '1' then
            status_count <= (others => '0');
        elsif rising_edge(clk) then
            if (we = '1' and re = '0' and status_count /= ram_depth) then
                status_count <= std_logic_vector(unsigned(status_count) + 1);
            elsif (re = '1' and we = '0' and status_count /= 0) then
                status_count <= std_logic_vector(unsigned(status_count) - 1);
            end if;
        end if;
    end process;

    full <= '1' when status_count = ram_depth else '0';
    empty <= '1' when status_count = 0 else '0';

    -- Data output logic
    process (clk, rst)
    begin
        if rst = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if re = '1' then
                data_out <= data_ram;
            end if;
        end if;
    end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo_tb is
end fifo_tb;

architecture Behavioral of fifo_tb is
    signal data_in_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal clk_tb : STD_LOGIC := '0';
    signal rst_tb : STD_LOGIC := '0';
    signal we_tb : STD_LOGIC := '0';
    signal re_tb : STD_LOGIC := '0';
    signal data_out_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal full_tb : STD_LOGIC;
    signal empty_tb : STD_LOGIC;

    component fifo
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR(7 downto 0);
               we : in STD_LOGIC;
               re : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR(7 downto 0);
               full : out STD_LOGIC;
               empty : out STD_LOGIC);
    end component;

begin
    -- Instantiate the FIFO
    DUT: fifo port map(
        clk => clk_tb,
        rst => rst_tb,
        data_in => data_in_tb,
        we => we_tb,
        re => re_tb,
        data_out => data_out_tb,
        full => full_tb,
        empty => empty_tb
    );

    -- Clock process
    clk_process : process
    begin
        clk_tb <= '1';
        wait for 5 ns;
        clk_tb <= '0';
        wait for 5 ns;
    end process;

    -- Reset process
    rst_process : process
    begin
        rst_tb <= '1';
        wait for 10 ns;
        rst_tb <= '0';
    end process;

    -- Test sequence
    process
    begin
        -- Initialize
        we_tb <= '0';
        re_tb <= '0';
        wait for 20 ns;

        -- Write data
        we_tb <= '1';
        for i in 0 to 15 loop
            data_in_tb <= std_logic_vector(to_unsigned(i * 10, 8));
            wait for 10 ns;
        end loop;
        we_tb <= '0';

        -- Read data
        re_tb <= '1';
        wait for 160 ns;
        re_tb <= '0';

        -- Reset
        rst_tb <= '1';
        wait for 10 ns;
        rst_tb <= '0';
        wait;
    end process;

end Behavioral;

