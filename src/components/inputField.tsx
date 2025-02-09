import {
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import { Feather } from "@expo/vector-icons";
import { colors } from "../constants/colors";
import React, { useState } from "react";

type FeatherIconName = keyof typeof Feather.glyphMap;

interface InputFieldProps {
  iconName: FeatherIconName;
  placeholder: string;
  secure: boolean;
  callback: (value: string) => void;
  value?: any;
  errorMsg?: string;
}

const InputField: React.FC<InputFieldProps> = ({
  iconName,
  placeholder,
  secure,
  callback,
  value,
  errorMsg,
}) => {
  const [text, setText] = useState<string>("");
  const [hide, setHide] = useState<boolean>(true);

  const handleTextChange = (input: string) => {
    setText(input);
    callback(input);
  };

  return (
    <View
      style={[
        styles.main,
        errorMsg ? { backgroundColor: colors.dark.errorPrimary } : null,
      ]}
    >
      <View
        style={[
          styles.inputContainer,
          errorMsg
            ? {
                backgroundColor: colors.dark.errorBg,
                borderColor: colors.dark.errorPrimary,
              }
            : { backgroundColor: "#282828", borderColor: "#9E9E9E44" },
        ]}
      >
        <Feather
          name={iconName}
          size={28}
          style={styles.icon}
        />
        <TextInput
          style={styles.input}
          placeholder={placeholder}
          placeholderTextColor={colors.dark.softGray}
          onChangeText={handleTextChange}
          secureTextEntry={secure ? hide : false}
          value={value}
          cursorColor={colors.dark.primary}
        />
        {secure && (
          <TouchableOpacity onPress={() => setHide(!hide)}>
            <Feather
              name={hide ? "eye-off" : "eye"}
              size={24}
              style={styles.hideIcon}
            />
          </TouchableOpacity>
        )}
      </View>
      {errorMsg && <Text style={styles.errorText}>* {errorMsg}</Text>}
    </View>
  );
};

export default InputField;

const styles = StyleSheet.create({
  inputContainer: {
    borderRadius: 12,
    borderWidth: 1,
    maxWidth: "90%",
    height: "auto",
    display: "flex",
    flexDirection: "row",
    width: "100%",
    alignItems: "center",
    elevation: 2,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.8,
    shadowRadius: 3,
  },
  main: {
    borderRadius: 12,
    marginVertical: 6,
  },
  icon: {
    marginVertical: 8,
    marginLeft: 8,
    color: colors.dark.softWhite,
  },
  input: {
    flex: 1,
    margin: 8,
    color: colors.dark.softWhite,
    fontSize: 18,
    fontWeight: 500,
  },
  hideIcon: {
    marginVertical: 8,
    marginRight: 8,
    color: colors.dark.softWhite,
  },
  errorText: {
    color: colors.dark.softWhite,
    fontWeight: "600",
    marginHorizontal: 12,
    fontSize: 12,
  },
});
