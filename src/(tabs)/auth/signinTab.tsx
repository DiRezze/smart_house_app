import { LinearGradient } from "expo-linear-gradient";
import React, { useState } from "react";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import { auth } from "../../firebase/firebaseConfig";
import PrimaryButton from "../../components/primaryButton";
import {
  ImageBackground,
  StyleSheet,
  Text,
  View,
  TextInput,
} from "react-native";
import { createUserWithEmailAndPassword } from "firebase/auth";
import InputField from "../../components/inputField";
import { SafeAreaView } from "react-native-safe-area-context";

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
    <SafeAreaView style={styles.imgBg}>
      <ImageBackground
        source={require("../../../assets/landing.png")}
        style={styles.imgBg}
      >
        <LinearGradient
          style={styles.imgBg}
          colors={["#060606", "#0606060c"]}
          start={{ x: 0, y: 1 }}
          end={{ x: 0, y: 0 }}
        >
          <BackNavigateButton />
        </LinearGradient>
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
      </ImageBackground>
    </SafeAreaView>
  );
};

export default SigninTab;

const styles = StyleSheet.create({
  imgBg: {
    flex: 1,
  },
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
