#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "linkedList.h"

llist *llist_create(char * name)
{
    struct node *new_node;

    llist *new_list = (llist *)malloc(sizeof (llist));
    *new_list = (struct node *)malloc(sizeof (struct node));
    
    new_node = *new_list;
    strcpy(new_node->data, name);
    new_node->next = NULL;
    return new_list;
}

void llist_free(llist *list)
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
int llist_add_inorder(char * name, llist *list)
{
    struct node *new_node;
    struct node *curr;
    struct node *prev = NULL;
    
    if (list == NULL || *list == NULL) {
        fprintf(stderr, "llist_add_inorder: list is null\n");
        return 0;
    }
    
    curr = *list;
    if (curr->data == NULL) {
        strcpy(curr->data, name);
        return 1;
    }

    new_node = (struct node *)malloc(sizeof (struct node));
    strcpy(new_node->data, name);
    // Find spot in linked list to insert new node
    while (curr != NULL && curr->data != NULL && strcmp(curr->data, name) < 0) {
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


int llist_search(llist *list, char * name) 
{ 
    struct node* current = *list;  // Initialize current 
    while (current != NULL) 
    { 
        if (strcmp(current->data, name) == 0) 
            return 1; 
        current = current->next; 
    } 
    return 0; 
}
