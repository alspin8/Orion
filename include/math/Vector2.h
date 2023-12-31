//
// Created by Alex on 13/12/2023.
//

#ifndef ORION_VECTOR2_H
#define ORION_VECTOR2_H

#include "math/Vector.h"
#include "core/type.h"

namespace orion {

    template<typename T>
    class Vector<2, T> : public VectorBase<2, T> {
    public:
        static const Vector<2, T> UP;
        static const Vector<2, T> DOWN;
        static const Vector<2, T> LEFT;
        static const Vector<2, T> RIGHT;

        Vector() = default;

        explicit Vector(T value);

        Vector(T x, T y);

        T get_x() const;
        T get_y() const;
    };

    template<typename T>
    using Vector2 = Vector<2, T>;

    using Vector2i = Vector2<i32>;
    using Vector2u = Vector2<u32>;
    using Vector2f = Vector2<f32>;
    using Vector2d = Vector2<f64>;

    template<typename T>
    const Vector<2, T> Vector<2, T>::UP = Vector<2, T>(0, 1);

    template<typename T>
    const Vector<2, T> Vector<2, T>::DOWN = Vector<2, T>(0, -1);

    template<typename T>
    const Vector<2, T> Vector<2, T>::LEFT = Vector<2, T>(-1, 0);

    template<typename T>
    const Vector<2, T> Vector<2, T>::RIGHT = Vector<2, T>(1, 0);

    template<typename T>
    Vector<2, T>::Vector(T x, T y) : VectorBase<2, T>({x, y}) {}

    template<typename T>
    Vector<2, T>::Vector(T value) : VectorBase<2, T>({value, value}) {}

    template<typename T>
    T Vector<2, T>::get_x() const {
        return this->m_data[0];
    }

    template<typename T>
    T Vector<2, T>::get_y() const {
        return this->m_data[1];
    }

} // orion

#endif //ORION_VECTOR2_H
