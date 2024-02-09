#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <cstdlib>
#include <unistd.h>

using namespace std;

extern "C"
{
    // Function to get hostname
    string getHostname()
    {
        char hostname[256];
        if (gethostname(hostname, sizeof(hostname)) != 0)
        {
            cerr << "Failed to get hostname" << endl;
            return "";
        }
        return hostname;
    }

    // Function to get platform
    string getPlatform()
    {
#ifdef __linux__
        return "Linux";
#elif __APPLE__
        return "macOS";
#elif _WIN32
        return "Windows";
#else
        return "Unknown";
#endif
    }

    // Function to get distribution
    string getDistribution()
    {
#ifdef __linux__
        string line;
        ifstream file("/etc/os-release");
        if (file.is_open())
        {
            while (getline(file, line))
            {
                if (line.find("PRETTY_NAME") != string::npos)
                {
                    file.close();
                    return line.substr(line.find_first_of('"') + 1, line.find_last_of('"') - line.find_first_of('"') - 1);
                }
            }
            file.close();
        }
        return "Unknown";
#else
        return "N/A";
#endif
    }

    // Function to get kernel release
    string getKernelRelease()
    {
#ifdef __linux__
        string line;
        ifstream file("/proc/sys/kernel/osrelease");
        if (file.is_open())
        {
            getline(file, line);
            file.close();
            return line;
        }
        return "Unknown";
#else
        return "N/A";
#endif
    }

    // Function to get CPU information
    string getCPUInfo(const string &key)
    {
        string line, value;
        ifstream file("/proc/cpuinfo");
        if (file.is_open())
        {
            while (getline(file, line))
            {
                if (line.find(key) != string::npos)
                {
                    istringstream iss(line.substr(line.find(":") + 2));
                    iss >> value;
                    file.close();
                    return value;
                }
            }
            file.close();
        }
        return "Unknown";
    }

    // Function to get CPU model
    string getCPUModel()
    {
        return getCPUInfo("model name");
    }

    // Function to get CPU core count
    string getCPUCoreCount()
    {
        return getCPUInfo("cpu cores");
    }

    // Function to get CPU speed
    string getCPUSpeed()
    {
        return getCPUInfo("cpu MHz");
    }
}

int main()
{
    cout << "Hostname: " << getHostname() << endl;
    cout << "Platform: " << getPlatform() << endl;
    cout << "Distribution: " << getDistribution() << endl;
    cout << "Kernel Release: " << getKernelRelease() << endl;
    cout << "CPU Model: " << getCPUModel() << endl;
    cout << "CPU Core Count: " << getCPUCoreCount() << endl;
    cout << "CPU Speed: " << getCPUSpeed() << " MHz" << endl;

    return 0;
}
