#include <stdio.h>
#include <string.h>
#include <stdint.h>
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
    res_array[res_count++] = start_array[0];

    for (;;) {
        count--;
        int all_zeros = 1;
        for (int i = 0; i < count; i++) {
            int diff = start_array[i + 1] - start_array[i];

            if (diff != 0) all_zeros = 0;
            start_array[i] = diff;

            // if (i == count-1) { Part I
            if (i == 0) { // Part II
                //res_array[res_count++] = start_array[i+1]; PART I
                res_array[res_count++] = start_array[i]; // PART II
            }
        }

        if (all_zeros) break;
    }

    free(start_array);
    /* PART I
    for (int i = 0; i < res_count; i++) {
        printf("%d ", res_array[i]);
        // *prediction += res_array[i];
    }
    */

    // PART II
    for (int i = res_count-2; i >= 0; i--) {
        *prediction = res_array[i] - *prediction;
    }

    free(res_array);
}

int main() {
    FILE  *file;
    char buffer[200];

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

    printf("\n%d", total_pred);
    fclose(file);

    return 0;
}









