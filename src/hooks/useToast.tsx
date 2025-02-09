import { ToastAndroid } from "react-native";

const useToast = () => {
  const showToast = (
    message: string | undefined,
    duration: "short" | "long" = "short"
  ) => {
    if (message) {
      ToastAndroid.show(
        message,
        duration === "short" ? ToastAndroid.SHORT : ToastAndroid.LONG
      );
    }
  };

  return { showToast };
};

export default useToast;
