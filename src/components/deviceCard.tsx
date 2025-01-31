import { View, Text, StyleSheet, TouchableOpacity } from "react-native";
import { colors } from "../constants/colors";
import BlankCard from "./blankCard";
import { Feather } from "@expo/vector-icons";

interface DeviceCardProps {
  deviceName: string;
  mqttTopic: string;
  onClick?: () => void;
  deviceState: boolean;
}
const DeviceCard: React.FC<DeviceCardProps> = ({
  deviceName,
  mqttTopic,
  deviceState,
  onClick,
}) => {
  const handlePress = () => {
    if (onClick) {
      onClick();
    }
  };

  return (
    <BlankCard>
      <TouchableOpacity
        onPress={handlePress}
        style={styles.container}
        activeOpacity={0.7}
      >
        <View style={styles.iconCircle}>
          <Feather
            name={"layers"}
            color={colors.dark.softWhite}
            size={32}
          />
        </View>
        <Text style={styles.text}>{deviceName}</Text>
        <TouchableOpacity
          style={[
            styles.power,
            {
              backgroundColor: deviceState
                ? colors.dark.secondary
                : colors.dark.softGray,
            },
          ]}
        >
          <Feather
            name="power"
            size={24}
            color={colors.dark.softWhite}
          />
        </TouchableOpacity>
      </TouchableOpacity>
    </BlankCard>
  );
};

export default DeviceCard;

const styles = StyleSheet.create({
  iconCircle: {
    borderRadius: 999,
    padding: 16,
    alignItems: "center",
    justifyContent: "center",
    width: 64,
    height: 64,
    margin: 8,
    backgroundColor: colors.dark.secondary,
  },
  text: {
    color: colors.dark.softWhite,
    fontSize: 20,
    textAlign: "left",
    marginLeft: 8,
    fontWeight: "700",
  },
  container: {
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-start",
    width: "100%",
  },
  power: {
    marginLeft: "auto",
    marginRight: 12,
    padding: 8,
    borderRadius: 48,
  },
});
