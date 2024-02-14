#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <unistd.h>

using namespace std;

class NetworkMonitor
{
public:
    NetworkMonitor()
    {
        // Initialize initial values
        readStats(m_InitialUploadBytes, m_InitialDownloadBytes);
    }

    pair<double, double> getInternetSpeed()
    {
        // Get current values
        unsigned long long currentUploadBytes, currentDownloadBytes;
        readStats(currentUploadBytes, currentDownloadBytes);

        // Calculate upload and download speeds
        double uploadSpeed = (currentUploadBytes - m_InitialUploadBytes) / 1024.0;       // Convert to KB
        double downloadSpeed = (currentDownloadBytes - m_InitialDownloadBytes) / 1024.0; // Convert to KB

        // Update initial values for next calculation
        m_InitialUploadBytes = currentUploadBytes;
        m_InitialDownloadBytes = currentDownloadBytes;

        return make_pair(uploadSpeed, downloadSpeed);
    }

private:
    unsigned long long m_InitialUploadBytes;
    unsigned long long m_InitialDownloadBytes;

    void readStats(unsigned long long &uploadBytes, unsigned long long &downloadBytes)
    {
        ifstream file("/proc/net/dev");
        if (!file.is_open())
        {
            cerr << "Failed to open /proc/net/dev" << endl;
            return;
        }

        // Skip the first two lines (headers)
        string line;
        getline(file, line);
        getline(file, line);

        // Extract interface name and stats
        while (getline(file, line))
        {
            istringstream iss(line);
            string interface;
            iss >> interface;

            if (interface.find(':') != string::npos)
            {
                unsigned long long rxBytes, txBytes;
                iss >> rxBytes >> txBytes;

                uploadBytes += txBytes;
                downloadBytes += rxBytes;
            }
        }

        file.close();
    }
};

int main()
{
    NetworkMonitor monitor;

    // Update speeds every second
    while (true)
    {
        auto speeds = monitor.getInternetSpeed();
        cout << "Upload Speed: " << speeds.first << " KB/s" << endl;
        cout << "Download Speed: " << speeds.second << " KB/s" << endl;
        sleep(1);        // Sleep for 1 second
        system("clear"); // Clear the console
    }

    return 0;
}
