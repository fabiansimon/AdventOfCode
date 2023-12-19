#import <Foundation/Foundation.h>

void *populate_content(const NSString *path, NSString **_content) {
    NSError *error = nil;
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    } else {
        *_content = content;
    }
}

NSArray<NSArray<NSString *> *> *create_instructions(NSString *input) {
    NSArray *lines = [input componentsSeparatedByString:@"\n"];
    NSMutableArray<NSArray<NSString *> *> *directions = [NSMutableArray array];

    for (NSString *line in lines) {
        NSArray *components = [line componentsSeparatedByString:@" "];

        if (components.count == 3) {
            NSString *direction = components[0];
            NSString *value = components[1];
            NSString *color = components[2];

            NSArray *transformed_direction = @[value, direction, color];
            [directions addObject:transformed_direction];
        }
    }

    return directions;
}

NSArray<NSNumber *>* calculate_size(NSArray<NSArray<NSString *> *> *directions) {

    NSInteger curr_width = 0, curr_height = 0, width = 0, height = 0;

    for (NSArray<NSString*> *d in directions) {
        NSInteger direction_val = [d[0] intValue];
        if ([d[1] isEqualToString:@"R"]) {
            curr_width += direction_val;
        }
        if ([d[1] isEqualToString:@"L"]) {
            curr_width -= direction_val;
        }
        if ([d[1] isEqualToString:@"U"]) {
            curr_height -= direction_val;
        }
        if ([d[1] isEqualToString:@"D"]) {
            curr_height += direction_val;
        }
        width = MAX(width, curr_width);
        height= MAX(height, curr_height);
    }
    width++; height++;

    return @[@(width), @(height)];
}

void generate_matrix(NSArray<NSNumber *> *size, NSArray<NSArray<NSString *> *> *directions) {
    NSInteger width = [size[1] intValue], height = [size[0] intValue];
    NSInteger distance = 0, currX = 0, currY = 0;
    NSString *direction = @"";

    char matrix[width][height];
    matrix[currX][currY] = '#';

    for (NSInteger i = 0; i < width; i++) {
        for (NSInteger j = 0; j < height; j++) {
            matrix[i][j] = '.';
        }
    }

    for (NSArray<NSString *> *d in directions) {
        distance = [d[0] intValue];
        direction = d[1];

        for (NSInteger i = 0; i < distance; i++) {
            if ([direction isEqualToString:@"R"] && currY + 1 < height) {
                currY++;
            } else if ([direction isEqualToString:@"L"] && currY - 1 >= 0) {
                currY--;
            } else if ([direction isEqualToString:@"U"] && currX - 1 >= 0) {
                currX--;
            } else if ([direction isEqualToString:@"D"] && currX + 1 < width) {
                currX++;
            }

            matrix[currX][currY] = '#';
        }
    }


    NSInteger total = 0; 
    BOOL count = false;
    for (NSInteger i = 0; i < width; i++) {
        count = false;
        for (NSInteger j = 0; j < height; j++) {
            if (matrix[i][j] == '#') {
                total++;
                if (j + 1 < height && matrix[i][j + 1] == '.') {
                    count = !count;
                }
            } else if (count) {
                total++;
            }

            printf("%c", matrix[i][j]);
        }
        printf("%d\n", total);
    }

    NSLog(@"Width: %ld", width);
    NSLog(@"Height: %ld", height);  
    NSLog(@"Total: %ld", total);  
}

int main(int argc, const char * argv[]) {
    NSString *path = @"./day18_input.txt";
    NSString *content;
    populate_content(path, &content);

    NSArray<NSArray<NSString *> *> *directions = create_instructions(content);

    NSArray<NSNumber *> *size = calculate_size(directions);

    generate_matrix(size, directions);
    return 0;
}
