#include "shape.hpp"

#pragma GCC diagnostic warning "-std=c++11"

// Base class
// Please implement Shape's member functions
// constructor, getName()
//
// Base class' constructor should be called in derived classes'
// constructor to initizlize Shape's private variable

Shape::Shape(string name) : name_(name) {}
string Shape::getName() { return name_; }


// Rectangle
// Please implement the member functions of Rectangle:
// constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here


Rectangle::Rectangle(double width, double length)
    : Shape("Rectangle"), width_(width), length_(length) {}
double Rectangle::getWidth() const { return width_; }
double Rectangle::getLength() const { return length_; }
double Rectangle::getArea() const { return length_ * width_; }
double Rectangle::getVolume() const { return 0; }

Rectangle Rectangle::operator+(const Rectangle &R) {
    return Rectangle(width_ + R.width_, length_ + R.length_);
}

Rectangle Rectangle::operator-(const Rectangle &R) {
    return Rectangle(max(0.0, width_ - R.width_), max(0.0, length_ - R.length_));
}



// Circle
// Please implement the member functions of Circle:
// constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Circle::Circle(double radius) : Shape("Circle"), radius_(radius){};
double Circle::getRadius() const { return radius_; }
double Circle::getArea() const { return M_PI * radius_ * radius_; }
double Circle::getVolume() const { return 0; }

Circle Circle::operator+(const Circle &C) { return Circle(radius_ + C.radius_); }
Circle Circle::operator-(const Circle &C) { return Circle(max(0.0, radius_ - C.radius_)); }

// Sphere
// Please implement the member functions of Sphere:
// constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here


Sphere::Sphere(double radius) : Shape("Sphere"), radius_(radius) {}
double Sphere::getRadius() const { return radius_; }
double Sphere::getArea() const { return 4.0 * M_PI * radius_ * radius_; }
double Sphere::getVolume() const { return 4.0 / 3.0 * M_PI * radius_ * radius_ * radius_; }

Sphere Sphere::operator+(const Sphere &S) { return Sphere(radius_ + S.radius_); }
Sphere Sphere::operator-(const Sphere &S) { return Sphere(max(0.0, radius_ - S.radius_)); }

// Rectprism
// Please implement the member functions of RectPrism:
// constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here

RectPrism::RectPrism(double width, double length, double height)
    : Shape("RectPrism"), width_(width), length_(length), height_(height) {}
double RectPrism::getWidth() const { return width_; }
double RectPrism::getHeight() const { return height_; }
double RectPrism::getLength() const { return length_; }
double RectPrism::getArea() const {
    return 2.0 * (width_ * height_ + height_ * length_ + width_ * length_);
}
double RectPrism::getVolume() const { return width_ * height_ * length_; }

RectPrism RectPrism::operator+(const RectPrism &RP) {
    return RectPrism(width_ + RP.width_, length_ + RP.length_, height_ + RP.height_);
}
RectPrism RectPrism::operator-(const RectPrism &RP) {
    return RectPrism(max(0.0, width_ - RP.width_), max(0.0, length_ - RP.length_),
                     max(0.0, height_ - RP.height_));
}


// Read shapes from test.txt and initialize the objects
// Return a vector of pointers that points to the objects
vector<Shape *> CreateShapes(char *file_name) {
    //@@Insert your code here
    vector<Shape *> result;

    ifstream infile;
    infile.open(file_name);
    int inputLength;
    infile >> inputLength;

    for (int i = 0; i < inputLength; i++) {
        Shape *S;
        string name;
        double d1, d2, d3;

        infile >> name;
        if (name == "Rectangle") {
            infile >> d1 >> d2;
            S = new Rectangle(d1, d2);
        } else if (name == "Circle") {
            infile >> d1;
            S = new Circle(d1);
        } else if (name == "Sphere") {
            infile >> d1;
            S = new Sphere(d1);
        } else if (name == "RectPrism") {
            infile >> d1 >> d2 >> d3;
            S = new RectPrism(d1, d2, d3);
        }

        result.push_back(S);
    }

    infile.close();
    return result;
}

// call getArea() of each object
// return the max area
double MaxArea(vector<Shape *> shapes) {
    double max_area = 0;
    //@@Insert your code here
    for (auto shape : shapes) {
        double shapeArea = shape->getArea();
        if (shapeArea > max_area) {
            max_area = shapeArea;
        }
    }
    return max_area;
}


// call getVolume() of each object
// return the max volume
double MaxVolume(vector<Shape *> shapes) {
    double max_volume = 0;
    //@@Insert your code here
    for (auto shape : shapes) {
        double shapeVolume = shape->getVolume();
        if (shapeVolume > max_volume) {
            max_volume = shapeVolume;
        }
    }
    return max_volume;
}
