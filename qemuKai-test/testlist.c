#define MAX_NUMS 256  // Assuming a maximum of 256 numbers for each list

#define __NR_printInt   244
#define __NR_readInt    245
#define __NR_printChar  246
#define __NR_readChar   247
#define __NR_printStr   248
#define __NR_readStr    249

// Global arrays
static int list1[MAX_NUMS], list2[MAX_NUMS];
static int count1, count2;
static int sum1, sum2;

// Global strings
static const char inputPrompt[] = "Enter numbers, stop at 0:\n";
static const char sumOutputFmt1[] = "Sum of the numbers for list 1: \n";
static const char sumOutputFmt2[] = "Sum of the numbers for list 2: \n";
static const char maxNumberLimit[] = "Maximum number limit reached.\n";

static void readNumbers(int *list, int *count) {
    int num;
    *count = 0;  // Initialize count to 0

    // printf("%s", inputPrompt);
    // syscall(__NR_printStr, inputPrompt);
    asm volatile (
        "li a7, 248\n\t"
        "la a0, inputPrompt\n\t"
        "ecall\n\t"
    );
    while (1) {
        // scanf("%d", &num);
        // num = syscall(__NR_readInt);
        asm volatile (
            "li a7, 245\n\t"
            "ecall\n\t"
            "move %0, a0\n\t"
            : "=r" (num)
        );
        if (num == 0) break;
        list[(*count)++] = num;

        // Check if the list is full
        if (*count >= MAX_NUMS) {
            // printf("Maximum number limit reached.\n");
            // syscall(__NR_printStr, maxNumberLimit);
            asm volatile (
                "li a7, 248\n\t"
                "la a0, maxNumberLimit\n\t"
                "ecall\n\t"
            );
            break;
        }
    }
}

static int calculateSum(const int *list, int count) {
    int sum = 0;
    for (int i = 0; i < count; i++) {
        sum += list[i];
    }
    return sum;
}

int main() {
    // Read numbers and calculate sum for list1
    readNumbers(list1, &count1);
    sum1 = calculateSum(list1, count1);

    // Read numbers and calculate sum for list2
    readNumbers(list2, &count2);
    sum2 = calculateSum(list2, count2);

    // Print the sums
    // printf(sumOutputFmt1, sum1);
    // syscall(__NR_printStr, sumOutputFmt1);
    // syscall(__NR_printInt, sum1);
    asm volatile (
        "li a7, 248\n\t"
        "la a0, sumOutputFmt1\n\t"
        "ecall\n\t"
        "li a7, 244\n\t"
        "move a0, %0\n\t"
        "ecall\n\t"
        "li a0, 10\n\t"
        "li a7, 246\n\t"
        "ecall\n\t"
        :
        : "r" (sum1)
    );
    // printf(sumOutputFmt2, sum2);
    // syscall(__NR_printStr, sumOutputFmt2);
    // syscall(__NR_printInt, sum2);
    asm volatile (
        "li a7, 248\n\t"
        "la a0, sumOutputFmt2\n\t"
        "ecall\n\t"
        "li a7, 244\n\t"
        "move a0, %0\n\t"
        "ecall\n\t"
        "li a0, 10\n\t"
        "li a7, 246\n\t"
        "ecall\n\t"
        :
        : "r" (sum2)
    );
    return 0;
}
