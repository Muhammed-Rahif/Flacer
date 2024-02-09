#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <unistd.h>
#include <c++/12/bits/stream_iterator.h>

using namespace std;

extern "C"
{

    // Function to get the number of CPU cores
    int getCoreCount()
    {
        ifstream cpuinfo("/proc/cpuinfo");
        string line;
        int coreCount = 0;
        while (getline(cpuinfo, line))
        {
            if (line.substr(0, 9) == "processor")
            {
                coreCount++;
            }
        }
        return coreCount;
    }

    // Function to get the current process CPU usage percentage
    float getProcessCpuUsage()
    {

        static unsigned long long lastTotalUser, lastTotalUserLow, lastTotalSys, lastTotalIdle;

        double percent;
        FILE *file;
        unsigned long long totalUser, totalUserLow, totalSys, totalIdle, total;

        file = fopen("/proc/stat", "r");
        fscanf(file, "cpu %llu %llu %llu %llu", &totalUser, &totalUserLow,
               &totalSys, &totalIdle);
        fclose(file);

        if (totalUser < lastTotalUser || totalUserLow < lastTotalUserLow ||
            totalSys < lastTotalSys || totalIdle < lastTotalIdle)
        {
            // Overflow detection. Just skip this value.
            percent = -1.0;
        }
        else
        {
            total = (totalUser - lastTotalUser) + (totalUserLow - lastTotalUserLow) +
                    (totalSys - lastTotalSys);
            percent = total;
            total += (totalIdle - lastTotalIdle);
            percent /= total;
            percent *= 100;
        }

        lastTotalUser = totalUser;
        lastTotalUserLow = totalUserLow;
        lastTotalSys = totalSys;
        lastTotalIdle = totalIdle;

        return percent;
    }

    // Function to get the total CPU time
    long getTotalCpuTime()
    {
        ifstream stat("/proc/stat");
        string line;
        if (getline(stat, line))
        {
            istringstream iss(line);
            vector<string> tokens(istream_iterator<string>{iss},
                                  istream_iterator<string>());
            long total_time = 0;
            for (size_t i = 1; i < tokens.size(); ++i)
            {
                total_time += stol(tokens[i]);
            }
            return total_time;
        }
        return -1;
    }

    // Function to get the percentage of work for each CPU core
    vector<float> getCpuUsagePerCore()
    {
        ifstream stat("/proc/stat");
        string line;
        vector<float> cpu_usage;
        while (getline(stat, line))
        {
            if (line.substr(0, 3) == "cpu")
            {
                istringstream iss(line);
                vector<string> tokens(istream_iterator<string>{iss},
                                      istream_iterator<string>());
                long total_time = 0;
                for (size_t i = 1; i < tokens.size(); ++i)
                {
                    total_time += stol(tokens[i]);
                }
                float cpu_usage_percentage = (total_time / static_cast<float>(getTotalCpuTime())) * 100.0f;
                cpu_usage.push_back(cpu_usage_percentage);
            }
        }
        return cpu_usage;
    }
}

int main()
{
    cout << "CPU Cores: " << getCoreCount() << endl;
    cout << "Process CPU Usage: " << getProcessCpuUsage() << "%" << endl;
    cout << "Total CPU Time: " << getTotalCpuTime() << endl;
    cout << "CPU Usage Per Core: ";
    for (auto &cpu_usage : getCpuUsagePerCore())
    {
        cout << cpu_usage << "% ";
    }
    cout << endl;
    return 0;
}