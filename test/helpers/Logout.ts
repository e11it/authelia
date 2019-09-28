import { WebDriver } from "selenium-webdriver";
import ClickOnLink from "./ClickOnLink";
import VisitPageAndWaitUrlIs from "./behaviors/VisitPageAndWaitUrlIs";
import VerifyIsFirstFactorStage from "./assertions/VerifyIsFirstFactorStage";

export default async function(driver: WebDriver) {
  await VisitPageAndWaitUrlIs(driver, "https://login.example.com:8080/#/");
  await ClickOnLink(driver, 'Logout');
  // await VerifyIsFirstFactorStage(driver);
}