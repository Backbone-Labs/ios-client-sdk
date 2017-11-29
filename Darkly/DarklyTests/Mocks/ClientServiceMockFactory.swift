//
//  ClientServiceMockFactory.swift
//  DarklyTests
//
//  Created by Mark Pokorny on 11/13/17. +JMJ
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

@testable import Darkly

struct ClientServiceMockFactory: ClientServiceCreating {
    func makeFlagCache(maxCachedValues: Int) -> LDFlagCache {
        return LDFlagCache(maxCachedValues: maxCachedValues, keyedValueStore: KeyedValueStoringMock())
    }

    func makeFlagCache() -> LDFlagCache {
        return LDFlagCache(keyedValueStore: KeyedValueStoringMock())
    }

    func makeDarklyServiceProvider(mobileKey: String, config: LDConfig, user: LDUser) -> DarklyServiceProvider {
        return DarklyServiceMock(config: config, user: user)
    }

    func makeFlagSynchronizer(mobileKey: String, streamingMode: LDStreamingMode, pollingInterval: TimeInterval, service: DarklyServiceProvider, store: LDFlagMaintaining) -> LDFlagSynchronizing {
        let synchronizerMock = LDFlagSynchronizingMock()
        synchronizerMock.streamingMode = streamingMode
        synchronizerMock.pollingInterval = pollingInterval
        synchronizerMock.service = service
        return synchronizerMock
    }

    func makeEventReporter(mobileKey: String, config: LDConfig, service: DarklyServiceProvider) -> LDEventReporting {
        let reporterMock = LDEventReportingMock()
        reporterMock.config = config
        return reporterMock
    }
}
