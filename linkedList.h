#ifndef _LINKEDLIST__H
#define _LINKEDLIST__H
struct node {
    char data[30];
    struct node *next;
    char type[10];
};

typedef struct node * llist;

/* llist_create: Create a linked list */
llist *llist_create(char * name);

/* llist_free: Free a linked list */
void llist_free(llist *list);

/* llist_add_inorder: Add to sorted linked list */
int llist_add_inorder(char * name, llist *list, char * type);

int llist_search(llist *list, char * name, char * auxtype);

int llist_print(llist *list);
#endif