#ifndef _INTLINKEDLIST__H
#define _INTLINKEDLIST__H
struct node {
    int num;
    struct node *next;
};

typedef struct node * intllist;

/* llist_create: Create a linked list */
intllist *intllist_create(int num);

/* llist_free: Free a linked list */
void intllist_free(intllist *list);

/* llist_add_inorder: Add to sorted linked list */
int intllist_add_inorder(int num, intllist *list);

int intllist_search(intllist *list, int num);

int intllist_print(intllist *list);
#endif