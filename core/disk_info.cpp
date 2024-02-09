#include <iostream>
#include <sys/statvfs.h>

using namespace std;

extern "C"
{

    unsigned long long getTotalDiskSpace(const char *path = "/")
    {
        struct statvfs fsInfo;
        if (statvfs(path, &fsInfo) != 0)
        {
            cerr << "Failed to get file system statistics for path: " << path << endl;
            return 0;
        }
        return (fsInfo.f_frsize * fsInfo.f_blocks) / 1024; // Convert to KB
    }

    unsigned long long getUsedDiskSpace(const char *path = "/")
    {
        struct statvfs fsInfo;
        if (statvfs(path, &fsInfo) != 0)
        {
            cerr << "Failed to get file system statistics for path: " << path << endl;
            return 0;
        }
        return ((fsInfo.f_frsize * (fsInfo.f_blocks - fsInfo.f_bfree)) / 1024); // Convert to KB
    }

    unsigned long long getAvailableDiskSpace(const char *path = "/")
    {
        struct statvfs fsInfo;
        if (statvfs(path, &fsInfo) != 0)
        {
            cerr << "Failed to get file system statistics for path: " << path << endl;
            return 0;
        }
        return ((fsInfo.f_frsize * fsInfo.f_bavail) / 1024); // Convert to KB
    }

} // extern "C"

int main()
{
    const char *path = "/"; // Change this to the path of the file system you want to check
    cout << "Total disk space: " << getTotalDiskSpace(path) << " KB" << endl;
    cout << "Used disk space: " << getUsedDiskSpace(path) << " KB" << endl;
    cout << "Available disk space: " << getAvailableDiskSpace(path) << " KB" << endl;

    return 0;
}
