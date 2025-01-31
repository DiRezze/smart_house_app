import React, { useState } from "react";
import { colors } from "../../constants/colors";
import { auth } from "../../firebase/firebaseConfig";
import PrimaryButton from "../../components/primaryButton";
import { StyleSheet, Text, View } from "react-native";
import { createUserWithEmailAndPassword } from "firebase/auth";
import InputField from "../../components/inputField";
import AuthLayout from "../../layouts/authLayout";

const SigninTab = () => {
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [repass, setRepass] = useState<string>("");

  const [errorMessage, setErrorMessage] = useState<string>("");

  const handleSignup = async () => {
    if (password !== repass) {
      setErrorMessage("As senhas não coincidem.");
      return;
    }
    try {
      await createUserWithEmailAndPassword(auth, email, password);
    } catch (error) {
      console.log("Erro ao criar usuário: ", error);
    }
  };

  return (
    <AuthLayout backButton={true}>
      <View style={styles.modal}>
        <View style={styles.formContainer}>
          <Text style={styles.title}>Cadastrar</Text>
          <InputField
            placeholder="E-mail"
            iconName="mail"
            secure={false}
            callback={setEmail}
          />
          <InputField
            placeholder="Crie uma senha"
            iconName="key"
            callback={setPassword}
            secure={true}
          />
          <InputField
            placeholder="Repita a senha"
            iconName="key"
            callback={setRepass}
            secure={true}
          />
          <PrimaryButton
            textContent={"Criar conta"}
            action={handleSignup}
            params={[email, password]}
          />
        </View>
      </View>
    </AuthLayout>
  );
};

export default SigninTab;

const styles = StyleSheet.create({
  modal: {
    backgroundColor: "#060606",
  },
  forgot: {
    color: colors.dark.softGray,
    fontSize: 16,
  },
  title: {
    fontSize: 48,
    textAlign: "center",
    fontWeight: 600,
    color: colors.dark.primary,
  },
  formContainer: {
    backgroundColor: colors.dark.background,
    width: "auto",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "flex-start",
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    padding: 8,
    gap: 8,
    minHeight: "75%",
  },
});
