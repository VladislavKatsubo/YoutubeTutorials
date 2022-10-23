import Cocoa


class Student {

    // Value must be assigned during initialization
    let username: String

    // Optionals
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?

    // Declared with a value
    var gpa: Double = 0.0

    init(username: String) {
        self.username = username
    }

}

let joe = Student(username: "joelovescode")

print("username: \(joe.username)")
print("firstName: \(joe.firstName)")
print("lastName: \(joe.lastName)")
print("email: \(joe.email)")
print("phone: \(joe.phone)")
print("GPA: \(joe.gpa)")

joe.firstName = "Joe"
joe.lastName = "Burgess"
joe.email = "joe@flatironschool.com"
joe.phone = "212-555-1212"

print("firstName: \(joe.firstName)")
print("lastName: \(joe.lastName)")
print("email: \(joe.email)")
print("phone: \(joe.phone)")

if
    let firstName = joe.firstName,
    let lastName = joe.lastName,
    let email = joe.email,
    let phone = joe.phone {

    print("firstName: \(firstName)")
    print("lastName: \(lastName)")
    print("email: \(email)")
    print("phone: \(phone)\n")

}
