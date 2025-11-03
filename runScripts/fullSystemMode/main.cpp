#include <iostream>
#include <unistd.h>
#include <dirent.h>

// Include gem5 m5ops header files
#include <gem5/m5ops.h>

int main() {

    m5_work_begin(0, 0);

    write(1, "Workload...\n", 12);

    m5_work_end(0, 0);


    // List directory
    struct dirent *d;
    DIR *dr;
    dr = opendir(".");
    if (dr != NULL) {
        std::cout << "List of Files & Folders:" << std::endl;
        for (d = readdir(dr); d != NULL; d = readdir(dr)) {
            std::cout << d->d_name << ", ";
        }
        std::cout << std::endl;
        closedir(dr);
    } else {
        std::cout << "Error Occured!" << std::endl;
    }

    return 0;
}