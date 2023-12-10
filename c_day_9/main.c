#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void predict_next_value(char* line, int* prediction) {
    int count = 0;
    char* temp = line;

    while (*temp != '\0') {
        if (*temp == ' ') {
            count++;
        }
        temp++;
    }
    count++;

    int* start_array = (int*)malloc(count * sizeof(int));

    int index = 0;
    temp = line;
    while (sscanf(temp, "%d", &start_array[index]) == 1) {
        while (*temp != '\0' && *temp != ' ') {
            temp++;
        }
        if (*temp == ' ') {
            temp++;
        }
        index++;
    }

    int* res_array = (int*) malloc(count * sizeof(int));
    int res_count = 0;

    for (;;) {
        count--;
        int all_zeros = 1;
        for (int i = 0; i < count; i++) {
            int diff = abs(start_array[i+1] - start_array[i]);

            if (diff != 0) all_zeros = 0;
            start_array[i] = diff;

            if (i == count-1) {
                res_array[res_count++] = start_array[i+1];
            }
        }

        if (all_zeros) break;
    }

    free(start_array);
    for (int i = 0; i < res_count; i++) {
        *prediction += res_array[i];
    }

}

int main() {
    FILE  *file;
    char buffer[100];

    file = fopen("../day9_input.txt", "r");

    if (file == NULL) {
        perror("Error");
        return 1;
    }

    int total_pred = 0;
    while (fgets(buffer, sizeof(buffer), file) != NULL) {
        int prediction = 0;
        predict_next_value(buffer, &prediction);
        total_pred += prediction;
    }

    printf("%d", total_pred);
    fclose(file);

    return 0;
}









