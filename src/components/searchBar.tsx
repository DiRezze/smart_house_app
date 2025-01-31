import { Feather } from "@expo/vector-icons";
import React, { useRef, useState } from "react";
import { TextInput, View, StyleSheet, TouchableOpacity } from "react-native";
import { colors } from "../constants/colors";

const SearchBar = (callbackFunc) => {
  const [isFocused, setIsFocused] = useState(false);
  const inputRef = useRef(null);

  return (
    <TouchableOpacity
      style={[styles.container, isFocused && styles.containerFocused]}
      onPress={() => inputRef.current?.focus()}
      activeOpacity={1}
    >
      <Feather
        name="search"
        style={styles.icon}
        size={24}
        color="white"
      />
      <TextInput
        ref={inputRef}
        style={[styles.input, isFocused && styles.inputFocused]}
        placeholder="Pesquisar..."
        placeholderTextColor="#888"
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
      />
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: colors.dark.background,
    borderWidth: 1,
    borderColor: "#4D4D4D",
    borderRadius: 8,
    padding: 8,
    margin: 16,
  },
  containerFocused: {
    backgroundColor: colors.dark.secondaryBackground,
    shadowColor: "#00BFFF",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.5,
    shadowRadius: 4,
  },
  icon: {
    marginHorizontal: 8,
  },
  input: {
    flex: 1,
    color: "white",
    backgroundColor: colors.dark.background,
    borderRadius: 8,
    padding: 8,
    fontSize: 18,
    fontWeight: 600,
  },
  inputFocused: {
    backgroundColor: colors.dark.secondaryBackground,
  },
});

export default SearchBar;
