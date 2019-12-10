#ifndef __CTFIXED_STRING_HPP__
#define __CTFIXED_STRING_HPP__ 

template<unsigned N>
struct FixedString {
    char buf[N + 1]{};
    constexpr FixedString(char const* s) {
        for (unsigned i = 0; i != N; ++i) buf[i] = s[i];
    }
    constexpr FixedString(const FixedString& other) {
        for (unsigned i = 0; i != N; ++i) buf[i] = other.buf[i];
    }
    constexpr operator char const*() const { return buf; }
};


template<unsigned N> FixedString(char const (&)[N]) -> FixedString<N - 1>;
template<unsigned N> FixedString(FixedString<N>) -> FixedString<N>;

#endif // __CTFIXED_STRING_HPP__
