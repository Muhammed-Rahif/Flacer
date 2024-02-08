#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

extern "C"
{

    // Function to read a specific field from /proc/meminfo
    long getMeminfoValue(const std::string &field)
    {
        std::ifstream meminfo("/proc/meminfo");
        std::string line;
        while (std::getline(meminfo, line))
        {
            if (line.substr(0, field.size()) == field)
            {
                std::istringstream iss(line.substr(field.size()));
                long value;
                iss >> value;
                return value;
            }
        }
        return -1; // Return -1 if field not found
    }

    // Function to get Swap used
    long getSwapUsed()
    {
        return getMeminfoValue("SwapTotal:") - getMeminfoValue("SwapFree:");
    }

    // Function to get Swap free
    long getSwapFree()
    {
        return getMeminfoValue("SwapFree:");
    }

    // Function to get Swap total
    long getSwapTotal()
    {
        return getMeminfoValue("SwapTotal:");
    }

    // Function to get Memory free
    long getMemoryFree()
    {
        return getMeminfoValue("MemFree:");
    }

    // Function to get Memory total
    long getMemoryTotal()
    {
        return getMeminfoValue("MemTotal:");
    }

    // Function to get Buffers
    long getBuffers()
    {
        return getMeminfoValue("Buffers:");
    }

    // Function to get Cached
    long getCached()
    {
        return getMeminfoValue("Cached:");
    }

    // Function to get Shmem
    long getShmem()
    {
        return getMeminfoValue("Shmem:");
    }

    // Function to get SReclaimable
    long getSReclaimable()
    {
        return getMeminfoValue("SReclaimable:");
    }

} // extern "C"

int main()
{
    std::cout << "Swap Used: " << getSwapUsed() << " kB\n";
    std::cout << "Swap Free: " << getSwapFree() << " kB\n";
    std::cout << "Swap Total: " << getSwapTotal() << " kB\n";
    std::cout << "Memory Free: " << getMemoryFree() << " kB\n";
    std::cout << "Memory Total: " << getMemoryTotal() << " kB\n";
    std::cout << "Buffers: " << getBuffers() << " kB\n";
    std::cout << "Cached: " << getCached() << " kB\n";
    std::cout << "Shmem: " << getShmem() << " kB\n";
    std::cout << "SReclaimable: " << getSReclaimable() << " kB\n";

    return 0;
}
