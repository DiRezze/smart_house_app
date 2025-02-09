import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import React from "react";
import { colors } from "../../constants/colors";
import { useAuth } from "../../contexts/authContext";
import InputField from "../../components/inputField";
import PrimaryButton from "../../components/primaryButton";
import AuthLayout from "../../layouts/authLayout";
import { useForm, Controller } from "react-hook-form";
import { useNavigation } from "@react-navigation/native";
import { LandingTabNavigationProp } from "../../types/navigation";

const LoginTab = () => {
  const { signIn } = useAuth();
  const navigation = useNavigation<LandingTabNavigationProp>();

  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm({
    defaultValues: {
      email: "",
      password: "",
    },
  });

  const onSubmit = (data: { email: string; password: string }) => {
    signIn(data.email, data.password);
  };

  return (
    <AuthLayout backButton={true}>
      <View style={styles.modal}>
        <View style={styles.formContainer}>
          <Text style={styles.title}>Acessar</Text>
          <Controller
            control={control}
            name="email"
            render={({ field: { onChange, value } }) => (
              <InputField
                placeholder="E-mail"
                iconName="mail"
                secure={false}
                value={value}
                callback={onChange}
                errorMsg={errors.email?.message}
              />
            )}
            rules={{
              required: "E-mail é obrigatório",
              pattern: {
                value: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
                message: "Formato de e-mail inválido",
              },
            }}
          />
          <Controller
            control={control}
            name="password"
            render={({ field: { onChange, value } }) => (
              <InputField
                placeholder="Senha"
                iconName="key"
                secure={true}
                value={value}
                callback={onChange}
                errorMsg={errors.password?.message}
              />
            )}
            rules={{
              required: "Senha é obrigatória",
              minLength: {
                value: 6,
                message: "A senha deve ter, pelo menos, 6 caracteres",
              },
            }}
          />
          <PrimaryButton
            textContent={"Login"}
            action={handleSubmit(onSubmit)}
          />
          <TouchableOpacity onPress={() => navigation.navigate("passReset")}>
            <Text style={styles.forgot}>Esqueceu sua senha?</Text>
          </TouchableOpacity>
        </View>
      </View>
    </AuthLayout>
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
    backgroundColor: colors.dark.softBlack,
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
