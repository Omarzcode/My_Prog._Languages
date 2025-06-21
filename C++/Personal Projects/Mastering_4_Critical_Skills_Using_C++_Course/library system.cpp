#include<iostream>
#include<cmath>
#include<string>
#include<algorithm>

using namespace std;
const int CONST_MAX = 20;
int added1 = 0;
int added2 = 0;

struct book
{
    string name;
    int id;
    int total_quantity;
    int total_borrowed;

    book()
    {
        name = "";
        id = 0;
        total_borrowed = 0;
        total_quantity = 0;
    }
    void borrow()
    {
        total_borrowed++;
    }
    void return1()
     {
    if (total_borrowed > 0)
        total_borrowed--;
    }
    void print_book_by_id()
    {
        cout << "ID: " << id << ", Name: " << name << ", Total Quantity: " << total_quantity << ", Total Borrowed: " << total_borrowed << endl;
    }
    void print_book_by_name()
    {
        cout << "Name: " << name << ", ID: " << id << ", Total Quantity: " << total_quantity << ", Total Borrowed: " << total_borrowed << endl;
    }
};

struct User
{
    string name;
    int id;
    int borrowed_books;
    int borrowed_books_ids[CONST_MAX];

    User()
    {
        name = "";
        id = 0;
        borrowed_books = 0;
        fill(borrowed_books_ids, borrowed_books_ids + CONST_MAX, 0);
    }
    void user_borrow(book borrowed)
    {
        borrowed_books_ids[borrowed_books++] = borrowed.id;
    }
    static bool compare(int a, int b)
    {
        return a > b;
    }
    void user_return(book returned)
    {
        for (int i = 0; i < borrowed_books; i++)
        {
            if (returned.id == borrowed_books_ids[i])
                borrowed_books_ids[i] = 0;
        }
        sort(borrowed_books_ids, borrowed_books_ids + borrowed_books, compare);
        borrowed_books--;
    }
    void print_user()
    {
        cout << "User: " << name << ", ID: " << id << ", Borrowed Books IDs: ";
        for (int i = 0; i < borrowed_books; i++)
        {
            cout << borrowed_books_ids[i] << " ";
        }
        cout << endl;
    }
};

struct library_system
{
    User users[CONST_MAX];
    book books[CONST_MAX];

    void add_book()
    {
        if (added1 >= CONST_MAX)
            {
            cout << "Cannot add more books (max 20).\n";
            return;
            }
        cout << "Enter book name: ";
        cin >> books[added1].name;
        cout << "Enter book ID: ";
        cin >> books[added1].id;
        cout << "Enter total quantity: ";
        cin >> books[added1].total_quantity;
        added1++;
        cout << "Book added successfully!\n";
    }
    void add_user()
    {
        if (added2 >= CONST_MAX)
            {
            cout << "Cannot add more users (max 20).\n";
            return;
            }
        cout << "Enter user name: ";
        cin >> users[added2].name;
        cout << "Enter user ID: ";
        cin >> users[added2].id;
        added2++;
        cout << "User added successfully!\n";
    }
    void user_borrow_book(string user_name, string book_name)
    {
        int my_user = -1, my_book = -1;
        for (int i = 0; i < added2; i++)
        {
            if (user_name == users[i].name)
                my_user = i;
        }
        for (int i = 0; i < added1; i++)
        {
            if (book_name == books[i].name)
                my_book = i;
        }
        if (my_user != -1 && my_book != -1)
        {
            if (books[my_book].total_borrowed < books[my_book].total_quantity)
                {
            books[my_book].borrow();
            users[my_user].user_borrow(books[my_book]);
            cout << "Book borrowed successfully!\n";

                }
        else    {
            cout << "No available copies to borrow!\n";
                }
        }
        else
        {
            cout << "User or book not found!\n";
        }
    }
   void user_return_book(string user_name, string book_name) {
    int my_user = -1, my_book = -1;

    for (int i = 0; i < added2; i++) {
        if (user_name == users[i].name)
            my_user = i;
    }
    for (int i = 0; i < added1; i++) {
        if (book_name == books[i].name)
            my_book = i;
    }

    if (my_user == -1 || my_book == -1) {
        cout << "User or book not found!\n";
        return;
    }

    bool has_borrowed = false;
    for (int i = 0; i < users[my_user].borrowed_books; i++) {
        if (books[my_book].id == users[my_user].borrowed_books_ids[i]) {
            has_borrowed = true;
            break;
        }
    }

    if (!has_borrowed) {
        cout << "User did not borrow this book!\n";
        return;
    }

    books[my_book].return1();
    users[my_user].user_return(books[my_book]);
    cout << "Book returned successfully!\n";
}
    void print_library_by_id()
    {
        cout << "Library Books (Sorted by ID):\n";
        for (int i = 0; i < added1; i++)
            books[i].print_book_by_id();
    }
    void print_library_by_name()
    {
        cout << "Library Books (Sorted by Name):\n";
        for (int i = 0; i < added1; i++)
            books[i].print_book_by_name();
    }
    void print_users()
    {
        cout << "Users:\n";
        for (int i = 0; i < added2; i++)
            users[i].print_user();
    }
    void search_book_by_prefix(string prefix)
    {
        cout << "Books with prefix '" << prefix << "':\n";
        for (int i = 0; i < added1; i++)
        {
            if (books[i].name.find(prefix) == 0)
                cout << books[i].name << endl;
        }
    }
    void print_who_borrowed_book_by_name(string book_name)
    {
        int my_book = -1;
        for (int i = 0; i < added1; i++)
        {
            if (book_name == books[i].name)
                my_book = i;
        }
        if (my_book != -1)
        {
            cout << "Users who borrowed '" << book_name << "':\n";
            for (int i = 0; i < added2; i++)
            {
                for (int j = 0; j < users[i].borrowed_books; j++)
                {
                    if (books[my_book].id == users[i].borrowed_books_ids[j])
                        cout << users[i].name << "\n";
                }
            }
        }
        else
        {
            cout << "Book not found!\n";
        }
    }
};

void menu()
{
    library_system lib;
    int choice;
    do
    {
        cout << "\nLibrary Management System";
        cout << "\n1. Add a new book";
        cout << "\n2. Search books by prefix";
        cout << "\n3. Print who borrowed a specific book";
        cout << "\n4. Print library books sorted by ID";
        cout << "\n5. Print library books sorted by name";
        cout << "\n6. Add a new user";
        cout << "\n7. Borrow a book";
        cout << "\n8. Return a book";
        cout << "\n9. Print all users";
        cout << "\n10. Exit";
        cout << "\nEnter your choice: ";
        cin >> choice;

        string name1, name2;
        switch (choice)
        {
        case 1:
            lib.add_book();
            break;
        case 2:
            cout << "Enter book prefix: ";
            cin >> name1;
            lib.search_book_by_prefix(name1);
            break;
        case 3:
            cout << "Enter book name: ";
            cin >> name1;
            lib.print_who_borrowed_book_by_name(name1);
            break;
        case 4:
            lib.print_library_by_id();
            break;
        case 5:
            lib.print_library_by_name();
            break;
        case 6:
            lib.add_user();
            break;
        case 7:
            cout << "Enter user name: ";
            cin >> name1;
            cout << "Enter book name: ";
            cin >> name2;
            lib.user_borrow_book(name1, name2);
            break;
        case 8:
            cout << "Enter user name: ";
            cin >> name1;
            cout << "Enter book name: ";
            cin >> name2;
            lib.user_return_book(name1, name2);
            break;
        case 9:
            lib.print_users();
            break;
        case 10:
            cout << "Exiting program...\n";
            break;
        default:
            cout << "Invalid choice! Please try again.\n";
        }
    } while (choice != 10);
}

int main()
{
    menu();
    return 0;
}
