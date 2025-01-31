import {
  ImageBackground,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import React, { useState } from "react";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import { useAuth } from "../../contexts/authContext";
import InputField from "../../components/inputField";
import PrimaryButton from "../../components/primaryButton";

const LoginTab = () => {
  const { signIn } = useAuth();
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  return (
    <View style={styles.imgBg}>
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
            <Text style={styles.title}>Acessar</Text>
            <InputField
              placeholder="E-mail"
              iconName="mail"
              secure={false}
              callback={setEmail}
            />
            <InputField
              placeholder="Senha"
              iconName="key"
              secure={true}
              callback={setPassword}
            />
            <PrimaryButton
              textContent={"Login"}
              action={signIn}
              params={[email, password]}
            />
            <TouchableOpacity>
              <Text style={styles.forgot}>Esqueceu sua senha?</Text>
            </TouchableOpacity>
          </View>
        </View>
      </ImageBackground>
    </View>
  );
};

export default LoginTab;

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
