#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "integerLinkedList.h"

intllist *intllist_create(int num)
{
    struct node *new_node;

    intllist *new_list = (intllist *)malloc(sizeof (intllist));
    *new_list = (struct node *)malloc(sizeof (struct node));
    
    new_node = *new_list;
    new_node->num = num;
    new_node->next = NULL;
    return new_list;
}

void intllist_free(intllist *list)
{
    struct node *curr = *list;
    struct node *next;

    while (curr != NULL) {
        next = curr->next;
        free(curr);
        curr = next;
    }

    free(list);
}

// Returns 0 on failure
int intllist_add_inorder(int num, intllist *list)
{
    struct node *new_node;
    struct node *curr;
    struct node *prev = NULL;
    if (list == NULL || *list == NULL) {
        fprintf(stderr, "llist_add_inorder: list is null\n");
        return 0;
    }
    
    curr = *list;

    new_node = (struct node *)malloc(sizeof (struct node));
    new_node->num = num;
    // Find spot in linked list to insert new node
    while (curr != NULL && curr->num < num) {
        prev = curr;
        curr = curr->next;
    }
    new_node->next = curr;

    if (prev == NULL) 
        *list = new_node;
    else 
        prev->next = new_node;
    return 1;
}


int intllist_search(intllist *list, int num) 
{ 
    struct node* current = *list;  // Initialize current 
    while (current != NULL) 
    { 
        if (current->num == num){
            return 1;
        } 
        current = current->next; 
    } 
    return 0; 
}

void intllist_remove(intllist *list, int num){
    struct node * current = *list;
    if(current->num == num){
        if(current->next == NULL){
            printf("You can't delete the last element of a list!");
        }else{
            *list = current->next;
            free(current);
        }
    }else{
        struct node * prev = current;
        current = current->next;
        while(current != NULL){
            if(current->num == num){
                if(current->next != NULL){
                    prev->next = current->next;
                    free(current);
                    return;
                }else{
                    prev->next = NULL;
                    free(current);
                    return;
                }
            }
            prev = current;
            current = current->next;
        }
    }
}

int intllist_print(intllist *list) 
{ 
    struct node* current = *list;  // Initialize current
    while (current != NULL) 
    { 
        
        printf("%d \n", current->num);
        current = current->next;
    } 
    return 0; 
}
