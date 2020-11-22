struct node {
    char data[20];
    struct node *next;
};

typedef struct node * llist;

/* llist_create: Create a linked list */
llist *llist_create(char * name);

/* llist_free: Free a linked list */
void llist_free(llist *list);

/* llist_add_inorder: Add to sorted linked list */
int llist_add_inorder(char * name, llist *list);

int llist_search(llist *list, char * name);